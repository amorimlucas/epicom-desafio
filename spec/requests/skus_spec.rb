require 'rails_helper'

RSpec.describe "Skus", type: :request do
	context "teste CRUD inicial" do
	    it "GET /api/v1/skus retorna 200" do
	      get api_v1_skus_path
	      expect(response).to have_http_status(200)
	    end
   	end

    context "testes para requisito 1 do Desafio Epicom" do
    	let(:params) do {tipo: "sku_associado", dataEnvio: "2015-07-14T13:56:36", parametros: {idProduto: 100, idSku: 200}} end
		let(:headers) do { CONTENT_TYPE: "application/json" } end
		let(:sku1) do  
			Sku.create id: 200, idProduto: 50 
		end
    	it "POST notificação para /api/v1" do
    		post api_v1_path, params, headers
    		
			expect(response).to have_http_status(200)
			expect(test_sku.reload.parametros.idProduto).to eq (200)
    	end

    end
end