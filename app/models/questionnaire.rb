class Questionnaire < ApplicationRecord
  has_many :questions, -> { order(:position) }, dependent: :destroy
  validates :title, presence: true
end
