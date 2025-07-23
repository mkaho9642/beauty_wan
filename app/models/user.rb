class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :post_reviews, dependent: :destroy
  has_many :post_comments, dependent: :destroy
  has_one_attached :profile_image

  has_many :favorites, dependent: :destroy
  has_many :favoriting_salons, through: :favorites, source: :salon
  def favorited_by?(salon)
    favorites.exists?(salon_id: salon.id)
  end
  
  validates :name, presence: true, length: { minimum: 2, maximum: 20 }
  validates :name, uniqueness: { case_sensitive: false }, on: :update
  validates :nickname, presence: true, length: { minimum: 2, maximum: 20 }
  validates :email, presence: true, uniqueness: { case_sensitive: false }, format: { with: URI::MailTo::EMAIL_REGEXP }

  def get_profile_image(width, height)
    unless profile_image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    profile_image.variant(resize_to_limit: [width, height]).processed
  end

  def active_for_authentication?
    super && is_active
  end

  def self.search_for(content, method)
    if method == 'perfect'
      User.where(name: content)
    elsif method == 'forward'
      User.where('name LIKE ?', content + '%')
    elsif method == 'backward'
      User.where('name LIKE ?', '%' + content)
    else
      User.where('name LIKE ?', '%' + content + '%')
    end
  end

  def posts
    return Post.where(user_id: self.id)
  end
end
