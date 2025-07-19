class Salon < ApplicationRecord
  has_one_attached :image
  has_many :post_reviews, dependent: :destroy

  belongs_to :genre, optional: true

  with_options presence: true do
    validates :name
    validates :introduction
    validates :image
  end

  has_many :favorites, dependent: :destroy
  has_many :favoriting_users, through: :favorites, source: :user
  
  def self.search_for(content, method)
    if method == 'perfect'
      Salon.where(name: content)
    elsif method == 'forward'
      Salon.where('name LIKE ?', content + '%')
    elsif method == 'backward'
      Salon.where('name LIKE ?', '%' + content)
    else
      Salon.where('name LIKE ?', '%' + content + '%')
    end
  end

  def favorited_by?(user)
    favorites.exists?(user_id: user.id) if user.present?
  end
end