class BasicUserSerializer < ActiveModel::Serializer
  attributes :id, :email, :nickname, :last_name, :name, :avatar_url

  root :user
end
