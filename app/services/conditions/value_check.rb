module Conditions
  class ValueCheck
    def initialize(defn, responses)
      @question_id = defn['question_id']
      @value       = defn['value']
      @responses   = responses
    end

    def true?
      @responses[@question_id.to_s] == @value
    end
  end
end
