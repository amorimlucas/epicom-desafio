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
		end
	end
end