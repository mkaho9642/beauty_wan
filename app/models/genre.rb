class Genre < ApplicationRecord
  has_many :salons
  validates :name, presence: true, uniqueness: true
end