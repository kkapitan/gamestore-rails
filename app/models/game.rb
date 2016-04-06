class Game < ActiveRecord::Base
  validates :title, presence: true
  validates :description, presence: true
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }

  scope :filter_by_title, lambda { |keyword| where("lower(title) LIKE ?", "%#{keyword.downcase}%")}
  scope :above_or_equal_to_price, lambda { |price| where("price >= ?", price)}
  scope :below_or_equal_to_price, lambda { |price| where("price <= ?", price)}
end
