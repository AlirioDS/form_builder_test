module Conditions
  class AndCondition
    def initialize(defn, responses)
      @conditions = defn['conditions']
      @responses  = responses
    end

    def true?
      @conditions.all? { |c| Conditions.build(c, @responses).true? }
    end
  end
end
