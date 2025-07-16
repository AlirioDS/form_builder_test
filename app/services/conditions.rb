module Conditions
  def build(defn, responses)
    case defn['type']
    when 'value' then ValueCheck.new(defn, responses)
    when 'and'   then AndCondition.new(defn, responses)
    when 'or'    then OrCondition.new(defn, responses)
    when 'not'   then NotCondition.new(defn, responses)
    else raise "Unknown condition type: #{defn['type']}"
    end
  end
  
  module_function :build
end
