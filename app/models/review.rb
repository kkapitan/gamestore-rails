class Review < ActiveRecord::Base
  belongs_to :user
  belongs_to :game

  validates :title, presence:true, length: { maximum: 50 }
  validates :body, presence:true, length: { maximum: 200 }
  validates :mark, presence:true, numericality: { only_integer: true, less_than_or_equal_to: 10, greater_than_or_equal_to: 0}
end
