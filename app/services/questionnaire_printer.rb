class QuestionnairePrinter
  def initialize(questionnaires, all_responses)
    @questionnaires = questionnaires
    @responses      = all_responses
  end

  # Renders all questionnaires in one string, separated by blank lines
  def render
    @questionnaires
      .map { |form| render_form(form) }
      .join("\n\n")
  end

  private

  # Render a single questionnaire with visibility logic
  def render_form(form)
    lines     = ["** #{form['title']} **"]
    responses = @responses.fetch(form['id'], {})
    
    # Merge all responses for cross-form conditions
    all_responses = @responses.values.reduce({}, :merge)

    question_number = 1
    
    form['questions'].each do |q|
      visible = visible?(q, all_responses)
      
      # Skip invisible questions completely
      next unless visible

      # Only show visible questions with correct numbering
      lines << "#{question_number}. #{q['label']}"
      lines.concat(format_question(q, all_responses))
      
      question_number += 1
    end

    lines.join("\n")
  end

  # Determine if a question should be shown
  def visible?(q, resp)
    cond = q['visibility_condition']
    return true if cond.nil? || cond.empty?
    Conditions.build(cond, resp).true?
  end

  # Generate a short explanation for why a question is invisible
  def visibility_reason(q, resp)
    cond = q['visibility_condition']
    case cond['type']
    when 'value'
      actual_value = resp[cond['question_id']]
      expected_value = cond['value']
      "#{human_label(cond['question_id'])}: got #{actual_value.inspect}, expected #{expected_value.inspect}"
    when 'and'
      cond['conditions']
        .map { |c| visibility_reason({'visibility_condition' => c}, resp) }
        .join(' AND ')
    when 'or'
      cond['conditions']
        .map { |c| visibility_reason({'visibility_condition' => c}, resp) }
        .join(' OR ')
    when 'not'
      inner = cond['condition']
      "NOT(#{visibility_reason({'visibility_condition' => inner}, resp)})"
    else
      cond.to_s
    end
  end

  # Lookup a question's label by its ID for human-friendly reasons
  def human_label(question_id)
    question = @questionnaires
                 .flat_map { |f| f['questions'] }
                 .find { |qq| qq['id'] == question_id }
    question ? question['label'] : question_id
  end

  # Format the question's help text or options
  def format_question(q, resp)
    case q['question_type']
    when 'text'
      user_input = resp[q['id']]
      if user_input && !user_input.empty?
        ["   #{user_input}"]
      else
        ["   [No answer provided]"]
      end

    when 'boolean'
      %w[true false].map do |v|
        sel = resp[q['id']] == (v == 'true')
        "   #{sel ? '(x)' : '( )'} #{v.capitalize}"
      end

    when 'radio', 'dropdown'
      q['config']['options'].map do |opt|
        sel = resp[q['id']] == opt['value']
        "   #{sel ? '(x)' : '( )'} #{opt['label']}"
      end

    when 'checkbox'
      q['config']['options'].map do |opt|
        sel = resp[q['id']].to_a.include?(opt['value'])
        "   #{sel ? '[x]' : '[ ]'} #{opt['label']}"
      end

    else
      ["   Unknown question type: #{q['question_type']}"]
    end
  end
end
