class CreateDropOffPackages < ActiveRecord::Migration[5.1]
  def change
    create_table :drop_off_packages do |t|
      t.string :tracking_ref
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
