require 'rails_helper'

RSpec.describe Question, type: :model do
  let(:qn) { Questionnaire.create!(id: 'foo', title: 'Foo') }
  subject { qn.questions.build(id: 'q1', label: 'Q1?', question_type: 'text') }

  it 'is valid with required attributes' do
    expect(subject).to be_valid
  end

  it 'is invalid without a label' do
    subject.label = ''
    expect(subject).not_to be_valid
    expect(subject.errors[:label]).to include("can't be blank")
  end

  it 'won’t accept a non‐existent question_type' do
    expect { subject.question_type = 'foo' }.to raise_error(ArgumentError)
  end
end
