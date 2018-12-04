require 'rails_helper'

RSpec.describe "Skus", type: :request do
	context "teste CRUD inicial" do
	    it "GET /api/v1/skus retorna 200" do
	      get api_v1_skus_path
	      expect(response).to have_http_status(200)
	    end
   	end

    context "testes para requisito 1 do Desafio Epicom" do
    	params = {"tipo" => "sku_associado", "dataEnvio" => "2015-07-14T13:56:36", "parametros" => {"idProduto" => 100, "idSku" => 5}}
		#let(:headers) do { CONTENT_TYPE: "application/json" } end
		headers = { "CONTENT_TYPE" => "application/json" }
		before do  
			@sku1 = Sku.create id: 5, idProduto: 50 
		end
    	it "POST notificação para /api/v1" do
    		post api_v1_path, params: params
    		
			expect(response).to have_http_status(200)
			expect(@sku1.reload.idProduto).to eq (100)
    	end

    end
end