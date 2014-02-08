class RemovePhoneFromVendors < ActiveRecord::Migration
  def change
    remove_column :vendors, :phone, :string
  end
end
