require 'net/http'
require 'net/https'
require 'uri'
require 'json'

module Api
	module V1
		class SkusController < ApplicationController

			def index 
				skus = Sku.all
				render json: {status: "SUCCESS", message: "Todos SKUs", data: skus}, status: :ok
			end

			def notification
				if params[:tipo] == "sku_associado" 
					sku = Sku.find(params[:parametros][:idSku])
					sku.update(idProduto: params[:parametros][:idProduto])
					sku.save
					render json: {status: 'SUCCESS', message:'SKU foi associado.', data: sku}, status: :ok
				end
			end

			def create
				if params[:tipo] == "criacao_sku" 
					sku = Sku.create(id: params[:parametros][:idSku], idProduto: params[:parametros][:idProduto])
					sku.save
					render json: {status: 'SUCCESS', message:'SKU foi criado.', data: sku}, status: :ok
				end
			end

			def show
				sku = Sku.find(params[:id])
        		render json: {status: 'SUCCESS', message:'SKU foi extraido.', data: sku}, status: :ok
			end

			def update
				sku = Sku.find(params[:id])
		        sku.update(idProduto: params[:idProduto])
		        render json: {status: 'SUCCESS', message:'SKU foi atualizado.', data: sku},status: :ok
			end

			def destroy
				sku = Sku.find(params[:id])
		        sku.destroy
		        render json: {status: 'SUCCESS', message:'SKU deletado.', data: sku},status: :ok
			end

			def return_filtered_skus
				filtered_skus = []
				Sku.limit(20).each do |sku|
					disponivel_endpoint = "marketplace/produtos/#{sku.idProduto}/skus/#{sku.id}/disponibilidade"
					url = "https://sandboxmhubapi.epicom.com.br/v1/#{disponivel_endpoint}"
					uri = URI(url)

					disponivel = nil
					preco = nil

					Net::HTTP.start(uri.host, uri.port,
					  :use_ssl => uri.scheme == 'https', 
					  :verify_mode => OpenSSL::SSL::VERIFY_NONE) do |http|

					  request = Net::HTTP::Get.new uri.request_uri
					  request.basic_auth '897F8D21A9F5A', 'Ip15q6u7X15EP22GS36XoNLrX2Jz0vqq'

					  response = http.request request # Net::HTTPResponse object

					  parsed = JSON.parse(response.body)
					  disponivel = parsed["disponivel"]
					  preco = parsed["preco"]

					  filtered_skus.push(sku) if disponivel && (preco.to_f < 40.0 && preco.to_f > 10.0)
					  
					end

				end
				render json: {status: 'SUCCESS', message:'SKU TEST', data: filtered_skus},status: :ok
				#data = JSON.parse("[#{filtered_skus.join(', ')}]")
				#render json: {status: 'SUCCESS', message:'SKUs disponíveis e entre R$10.0 e R$40.0.', data: data}, status: :ok
			end

		end
	end
end