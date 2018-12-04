class Sku < ApplicationRecord
	validates :idProduto, presence: true
	validates :id, presence: true

end
