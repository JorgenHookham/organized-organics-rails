class CreateVendors < ActiveRecord::Migration
  def change
    create_table :vendors do |t|
      t.string :name
      t.text :text
      t.string :phone

      t.timestamps
    end
  end
end
