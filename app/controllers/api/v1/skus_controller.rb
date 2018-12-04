module Api
	module V1
		class SkusController < ApplicationController
			def index 
				skus = Sku.all
				render json: {status: "SUCCESS", message: "Todos SKUs", data: skus}, status: :ok
			end
		end
	end
end