require 'net/http'
require 'net/https'
require 'uri'
require 'json'

module Api
	module V1
		class SkusController < ApplicationController

			# READ - cRud: Retorna todos arquivos na mesa SKU
			def index 
				skus = Sku.all
				render json: {status: "SUCCESS", message: "Todos SKUs", data: skus}, status: :ok
			end

			# REQUISITO 1 do Desafio Epicom
			# Recebe notificações de associação de SKU e atualiza o arquivo na mesa
			def notification
				if params[:tipo] == "sku_associado" 
					sku = Sku.find(params[:parametros][:idSku])
					sku.update(idProduto: params[:parametros][:idProduto])
					sku.save
					render json: {status: 'SUCCESS', message:'SKU foi associado.', data: sku}, status: :ok
				end
			end

			# CREATE - Crud: Cria um novo arquivo na mesa SKU
			def create
				if params[:tipo] == "criacao_sku" 
					sku = Sku.create(id: params[:parametros][:idSku], idProduto: params[:parametros][:idProduto])
					sku.save
					render json: {status: 'SUCCESS', message:'SKU foi criado.', data: sku}, status: :ok
				end
			end

			# READ - cRud: Retorna o arquivo da mesa de SKU de acordo com o ID passado 
			def show
				sku = Sku.find(params[:id])
        		render json: {status: 'SUCCESS', message:'SKU foi extraido.', data: sku}, status: :ok
			end

			# UPDATE - crUd: Atualiza o arquivo do ID passado na mesa SKU com os dados passados
			def update
				sku = Sku.find(params[:id])
		        sku.update(idProduto: params[:idProduto])
		        render json: {status: 'SUCCESS', message:'SKU foi atualizado.', data: sku},status: :ok
			end

			#DELETE - cruD: Deleta o arquivo do ID passado
			def destroy
				sku = Sku.find(params[:id])
		        sku.destroy
		        render json: {status: 'SUCCESS', message:'SKU deletado.', data: sku},status: :ok
			end

			# REQUISITO 3 do Desafio Epicom
			# Retorna em formato JSON todos arquivos da mesa local SKU que estão 
			# disponíveis e come preço entre 10.00 e 40.00 reais
			# Os dados de disponibilidade e preço são puxados do API sandboxmhubapi.epicom.com.br/v1/marketplace
			def return_filtered_skus
				filtered_skus = []
				Sku.all.each do |sku|
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
				data = filtered_skus.to_json
				render json: data, status: :ok
				#render json: {status: 'SUCCESS', message:'SKUs disponíveis e entre R$10.0 e R$40.0.', data: data}, status: :ok
			end

		end
	end
end