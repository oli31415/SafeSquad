class CreateIncidents < ActiveRecord::Migration[7.0]
  def change
    create_table :incidents do |t|
      t.references :user, null: false, foreign_key: true
      t.string :location
      t.boolean :is_closed

      t.timestamps
    end
  end
end
