class AddTypeToIncident < ActiveRecord::Migration[7.0]
  def change
    add_column :incidents, :type, :string
  end
end
