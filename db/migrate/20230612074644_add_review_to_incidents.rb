class AddReviewToIncidents < ActiveRecord::Migration[7.0]
  def change
    add_column :incidents, :review_rating, :integer
    add_column :incidents, :review_text, :string
  end
end
