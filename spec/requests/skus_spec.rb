require 'rails_helper'

RSpec.describe "Skus", type: :request do
  context "testes CRUD" do
    it "GET /api/v1/skus retorna 200" do
      get api_v1_skus_path
      expect(response).to have_http_status(200)
    end
  end
end
