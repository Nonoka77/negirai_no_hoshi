require 'rails_helper'

RSpec.describe "Calms", type: :request do
  describe "GET /create" do
    it "returns http success" do
      get "/calms/create"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /destroy" do
    it "returns http success" do
      get "/calms/destroy"
      expect(response).to have_http_status(:success)
    end
  end

end
