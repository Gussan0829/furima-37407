class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :nickname, presence: true
  validates :birth, presence: true
  validates :first_name_kan, presence: true
  validates :family_name_kan, presence: true
  validates :first_name_kana, presence: true
  validates :family_name_kana, presence: true

  has_many :items
  has_many :purchases
end
