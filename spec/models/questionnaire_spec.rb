require 'rails_helper'

RSpec.describe Questionnaire, type: :model do
  subject { described_class.new(id: 'foo', title: 'My Form') }

  it 'is valid with an id and title' do
    expect(subject).to be_valid
  end

  it 'is invalid without a title' do
    subject.title = ''
    expect(subject).not_to be_valid
    expect(subject.errors[:title]).to include("can't be blank")
  end

  it 'has many questions' do
    assoc = described_class.reflect_on_association(:questions)
    expect(assoc.macro).to eq :has_many
  end
end
