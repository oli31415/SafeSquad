class AddStuffToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :languages, :string
    add_column :users, :height, :string
    add_column :users, :medication, :string
  end
end
