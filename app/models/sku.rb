class Sku < ApplicationRecord
	validates :idProduto, presence: true
	validates :idSku, presence: true

end
