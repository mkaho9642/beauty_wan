class SalonGenre < ApplicationRecord
  belongs_to :salon
  belongs_to :genre
end
