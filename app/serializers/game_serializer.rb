class GameSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :price, :category_cd
end

