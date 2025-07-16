module Conditions
  class NotCondition
    def initialize(defn, responses)
      @condition = defn['condition']
      @responses = responses
    end

    def true?
      !Conditions.build(@condition, @responses).true?
    end
  end
end
