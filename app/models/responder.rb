class Responder < ApplicationRecord
  belongs_to :incident
  belongs_to :user
  validates :user_id, uniqueness: { scope: :incident_id }
end
