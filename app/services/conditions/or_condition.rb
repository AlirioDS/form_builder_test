module Conditions
  class OrCondition
    def initialize(defn, responses)
      @conditions = defn['conditions']
      @responses  = responses
    end

    def true?
      @conditions.any? { |c| Conditions.build(c, @responses).true? }
    end
  end
end
