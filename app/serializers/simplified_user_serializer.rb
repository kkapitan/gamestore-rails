class SimplifiedUserSerializer < ActiveModel::Serializer
  attributes :id, :email, :nickname, :last_name, :name, :avatar_url

  has_many :games
  root :user
end
