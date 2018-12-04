require 'rails_helper'

RSpec.describe "Skus", type: :request do
	context "teste CRUD inicial" do
	    it "GET /api/v1/skus retorna 200" do
	      get api_v1_skus_path
	      expect(response).to have_http_status(200)
	    end
   	end

    context "testes para requisito 1 do Desafio Epicom" do
    	
		before do  
			@sku1 = Sku.create id: 5, idProduto: 50 
		end
    	it "POST notificação para /api/v1" do
    		params = {"tipo" => "sku_associado", "dataEnvio" => "2015-07-14T13:56:36", "parametros" => {"idProduto" => 100, "idSku" => 5}}
			headers = { "CONTENT_TYPE" => "application/json" }
    		post api_v1_path, params: params
    		
			expect(response).to have_http_status(200)
			expect(@sku1.reload.idProduto).to eq (100)
    	end
    end

    context "testes para requisito 2 do Desafio Epicom" do
    	
    	it "CREATE: POST para /api/v1/skus" do
    		params = {"tipo": "criacao_sku", "dataEnvio": "2015-08-18T20:51:22", "parametros": {"idProduto": 270666,"idSku": 322666}}
    		headers = { "CONTENT_TYPE" => "application/json" }
    		post '/api/v1/skus', params: params
    		
			expect(response).to have_http_status(200)
			sku = Sku.find(322666)
			expect(sku.blank?).to eq (false)
			expect(sku.idProduto).to eq (270666)
    	end

    	before do  
			@sku2 = Sku.create id: 6, idProduto: 51
		end

    	it "READ: GET para /api/v1/skus/:id" do
    		params = {"id": 6}
    		headers = { "CONTENT_TYPE" => "application/json" }

    		get '/api/v1/skus/6'
    		
			expect(response).to have_http_status(200)
			data = JSON.parse(response.body);
			expect(data["data"]["idProduto"]).to eq (51)
    	end

    	before do  
			@sku3 = Sku.create id: 7, idProduto: 52
		end
    	
    	it "UPDATE: PUT para /api/v1/skus/:id" do
    		params = {"idProduto" => 101, "id" => 7}
    		headers = { "CONTENT_TYPE" => "application/json" }
    		
    		put '/api/v1/skus/7', params: params
    		
			expect(response).to have_http_status(200)
			expect(@sku3.reload.idProduto).to eq (101)
    	end

    	before do  
			@sku4 = Sku.create id: 8, idProduto: 53
		end

    	it "DELETE: DELETE para /api/v1/skus/:id" do    		
    		delete '/api/v1/skus/8'
    		
			expect(response).to have_http_status(200)
			sku = Sku.find_by(id: 8)
			expect(sku.blank?).to eq (true)
    	end

    end

    context "testes para requisito 3 do Desafio Epicom" do
    	it "GET para /api/v1 retorna lista de SKUs disponíveis e entre 10 e 40 reais" do    		
    		get '/api/v1'
    		
			expect(response).to have_http_status(200)
    	end
    end

end