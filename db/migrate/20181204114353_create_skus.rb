class CreateSkus < ActiveRecord::Migration[5.2]
  def change
    create_table :skus do |t|
      t.integer :idProduto
      t.integer :idSku

      t.timestamps
    end
  end
end
