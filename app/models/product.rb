class Product < ApplicationRecord
  has_many   :prices, dependent: :destroy
  belongs_to :category

  validates :name, presence: true

  accepts_nested_attributes_for :prices
end
