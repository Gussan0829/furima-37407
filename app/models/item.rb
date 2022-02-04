class Item < ApplicationRecord
  validates :name, presence: true
  validates :category_id, presence: true
  validates :price, presence: true
  validates :content, presence: true
  validates :charge_id, presence: true
  validates :date_id, presence: true
  validates :condition_id, presence: true
  validates :prefecture_id, presence: true
  
  belongs_to :user

  has_one_attached :image

end
