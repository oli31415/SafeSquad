class Incident < ApplicationRecord
  belongs_to :user
  has_many :users
end
