require 'rails_helper'

RSpec.describe 'Cheers', type: :request do
  describe 'GET /create' do
    it 'returns http success' do
      get '/cheers/create'
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /destroy' do
    it 'returns http success' do
      get '/cheers/destroy'
      expect(response).to have_http_status(:success)
    end
  end
end
