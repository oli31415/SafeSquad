class MedicalInfo < ApplicationRecord
  # belongs_to :user

  def self.list
    return [
      ["Choose", "Hypertension", "Diabetes", "Asthma", "Arthritis", "Depression", "Anxiety"],
      ["", "these", "are", "placeholders", "for", "now", "sasha"]
    ]
  end
end
