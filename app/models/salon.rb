class Salon < ApplicationRecord
  has_one_attached :image
  has_many :post_reviews, dependent: :destroy

  with_options presence: true do
    validates :name
    validates :introduction
    validates :image
  end
  
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
end