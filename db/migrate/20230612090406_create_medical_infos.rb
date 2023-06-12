class CreateMedicalInfos < ActiveRecord::Migration[7.0]
  def change
    create_table :medical_infos do |t|
      t.string :title
      t.string :description

      t.timestamps
    end
  end
end
