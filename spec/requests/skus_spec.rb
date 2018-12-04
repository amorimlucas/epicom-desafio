require 'rails_helper'

RSpec.describe "Skus", type: :request do
	context "teste CRUD inicial" do
	    it "GET /api/v1/skus retorna 200" do
	      get api_v1_skus_path
	      expect(response).to have_http_status(200)
	    end
   	end


    context "testes para requisito 1 do Desafio Epicom" do
    	it "PUT /api/v1/sku/:id" do

    		#json = 
    	end
    end
end