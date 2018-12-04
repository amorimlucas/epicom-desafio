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
		end
	end
end