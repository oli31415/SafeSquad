class AddHasArrivedToResponder < ActiveRecord::Migration[7.0]
  def change
    add_column :responders, :has_arrived, :boolean, default: false
  end
end
