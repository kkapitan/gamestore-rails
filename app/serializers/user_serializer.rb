class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :auth_token, :nickname, :last_name, :name, :avatar_url

  has_many :games
end
