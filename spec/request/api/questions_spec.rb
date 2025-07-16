require 'rails_helper'

RSpec.describe 'Questions API', type: :request do
  let!(:qn) { Questionnaire.create!(id: 'qz', title: 'Qz') }

  describe 'POST /api/questionnaires/:id/questions' do
    let(:valid) { { question: { id: 'q1', label: 'Q1?', question_type: 'text', position: 1 } } }

    it 'adds a question' do
      expect {
        post "/api/questionnaires/#{qn.id}/questions", params: valid
      }.to change(Question, :count).by(1)
      expect(response).to have_http_status(:created)
      json = JSON.parse(response.body)
      expect(json['label']).to eq('Q1?')
    end

    it 'rejects invalid payloads' do
      post "/api/questionnaires/#{qn.id}/questions", params: { question: { id: 'q2' } }
      expect(response).to have_http_status(:unprocessable_entity)
      expect(JSON.parse(response.body)['errors']).to include("Label can't be blank", "Question type can't be blank")
    end
  end

  describe 'DELETE /api/questions/:id' do
    let!(:q) { qn.questions.create!(id: 'q1', label: 'Q1?', question_type: 'text') }

    it 'deletes the question' do
      expect {
        delete "/api/questions/#{q.id}"
      }.to change(Question, :count).by(-1)
      expect(response).to have_http_status(:no_content)
    end
  end
end
