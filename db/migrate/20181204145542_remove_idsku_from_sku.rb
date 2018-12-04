class RemoveIdskuFromSku < ActiveRecord::Migration[5.2]
  def change
    remove_column :skus, :idSku, :integer
  end
end
