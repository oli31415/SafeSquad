class AddMedicalInfosToUser < ActiveRecord::Migration[7.0]
  def change
    add_reference :users, :medical_info, null: true, foreign_key: true
  end
end
