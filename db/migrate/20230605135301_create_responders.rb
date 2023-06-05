class CreateResponders < ActiveRecord::Migration[7.0]
  def change
    create_table :responders do |t|
      t.references :incident, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.string :location
      t.boolean :has_accepted

      t.timestamps
    end
  end
end
