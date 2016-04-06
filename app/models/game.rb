class Game < ActiveRecord::Base
  validates :title, presence: true
  validates :description, presence: true
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }

  scope :filter_by_title, lambda { |keyword| where("lower(title) LIKE ?", "%#{keyword.downcase}%")}
  scope :above_or_equal_to_price, lambda { |price| where("price >= ?", price)}
  scope :below_or_equal_to_price, lambda { |price| where("price <= ?", price)}

  def self.search(params = {} )
    games = Game.all

    games = games.filter_by_title(params[:keyword]) if params[:keyword]
    games = games.above_or_equal_to_price(params[:min_price]) if params[:min_price]
    games = games.below_or_equal_to_price(params[:max_price]) if params[:max_price]

    games
  end
end
