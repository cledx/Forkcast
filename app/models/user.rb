class User < ApplicationRecord
  has_many :favorites
  has_many :weeks
  has_many :day_templates
  has_many :days, through: :weeks
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  ALL_ALLERGIES = ["peanuts", "tree nuts", "shellfish", "dairy", "gluten", "soy", "eggs", "fish"]
end
