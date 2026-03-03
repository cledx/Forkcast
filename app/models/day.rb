class Day < ApplicationRecord
  has_many :dishes
  has_many :recipes, through: :dishes
  belongs_to :week
  validates :date, presence: true
end
