module Conditions
  class Base
    def initialize(defn, responses)
      @defn = defn
      @responses = responses
    end

    def true?; raise NotImplementedError; end
  end
end
