require 'rails_helper'

RSpec.describe Sku, type: :model do
  context '- testes de validação' do
  	it "- verifica que idProduto está presente." do
  		sku = Sku.new(id: 12345).save
  		expect(sku).to eq(false)
  	end

  	it "- verifica que idSku está presente." do
  		sku = Sku.new(idProduto: 12345).save
  		expect(sku).to eq(false)
  	end

  	it "- deve salvar corretamente." do
  		sku = Sku.new(id: 12345, idProduto: 12345).save
  		expect(sku).to eq(true)
  	end
  end
  context 'scope tests' do
  end
end
