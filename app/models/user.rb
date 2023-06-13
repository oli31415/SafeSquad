class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :incidents, dependent: :destroy
  has_many :responders, dependent: :destroy # aka is a responder on many incidents

  def medical_info
    MedicalInfo.find(medical_info_id)
  end

  def self.list
    return User.all.map{ |user| user.first_name }
  end

  # attr_accessor :emergency_contact_mum, :emergency_contact_dad, :blood_type, :allergies, :medications, :height, :language, :medical_conditions
  # to make profile fields editable

end
