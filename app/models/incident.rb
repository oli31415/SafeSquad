class Incident < ApplicationRecord
  belongs_to :user
  has_many :responders

  def self.types
    return [
      "many",
      "different",
      "types",
      "here"
    ]
  end
end
