class RemoveTextFromVendors < ActiveRecord::Migration
  def change
    remove_column :vendors, :text, :text
  end
end
