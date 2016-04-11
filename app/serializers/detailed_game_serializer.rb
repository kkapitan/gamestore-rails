class DetailedGameSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :price

  root :game
  has_many :reviews
end