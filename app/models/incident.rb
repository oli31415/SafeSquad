class Incident < ApplicationRecord
  belongs_to :user
  has_many :responders, dependent: :destroy

  def self.types
    return [
      "Medical",
      "Unpleasant encounter",
      "Minor accident",
      "Other"
    ]
  end
end
