class AddStreetToAddresses < ActiveRecord::Migration[5.1]
  def change
    add_column :addresses, :street, :string
    add_index :addresses, :street
  end
end
