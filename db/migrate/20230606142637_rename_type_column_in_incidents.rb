class RenameTypeColumnInIncidents < ActiveRecord::Migration[7.0]
  def change
    rename_column :incidents, :type, :incident_type
  end
end
