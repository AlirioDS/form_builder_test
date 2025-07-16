class Question < ApplicationRecord
  belongs_to :questionnaire
  enum :question_type, { text: 0, checkbox: 1, radio: 2, dropdown: 3, boolean: 4 }


  attribute :config, :json, default: {}
  attribute :visibility_condition, :json, default: {}

  validates :label, :question_type, presence: true
end
