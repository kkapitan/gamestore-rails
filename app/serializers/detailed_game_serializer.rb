class DetailedGameSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :price, :category_cd

  root :game
  has_many :reviews
end