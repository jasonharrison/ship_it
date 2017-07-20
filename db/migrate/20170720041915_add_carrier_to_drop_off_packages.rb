class AddCarrierToDropOffPackages < ActiveRecord::Migration[5.1]
  def change
    add_column :drop_off_packages, :carrier, :string
  end
end
