require 'rails_helper'

RSpec.describe 'Questionnaires API', type: :request do
  describe 'GET /api/questionnaires' do
    before { Questionnaire.create!(id: 'f1', title: 'Form 1') }

    it 'returns all questionnaires' do
      get '/api/questionnaires'
      expect(response).to have_http_status(:ok)
      data = JSON.parse(response.body)
      expect(data.first['id']).to eq('f1')
      expect(data.first['title']).to eq('Form 1')
    end
  end

  describe 'POST /api/questionnaires' do
    let(:valid_params) { { questionnaire: { id: 'f2', title: 'New Form' } } }

    it 'creates a questionnaire' do
      expect {
        post '/api/questionnaires', params: valid_params
      }.to change(Questionnaire, :count).by(1)
      expect(response).to have_http_status(:created)
      body = JSON.parse(response.body)
      expect(body['id']).to eq('f2')
    end

    it 'returns errors when invalid' do
      post '/api/questionnaires', params: { questionnaire: { id: 'f3', title: '' } }
      expect(response).to have_http_status(:unprocessable_entity)
      expect(JSON.parse(response.body)['errors']).to include("Title can't be blank")
    end
  end
end
