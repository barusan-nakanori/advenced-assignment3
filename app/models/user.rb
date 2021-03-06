class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :books, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favorited_books, through: :favorites, source: :book
  has_many :comments
  attachment :profile_image
  validates :name,presence: true,length: {minimum: 2 ,maximum: 20}
  validates :email,presence: true
  validates :introduction,length: {maximum: 50}

  def already_favorited?(book)
    self.favorites.exists?(book_id: book.id)
  end
end
