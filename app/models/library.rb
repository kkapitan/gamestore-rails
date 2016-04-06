class Library < ActiveRecord::Base
  belongs_to :user, inverse_of: :libraries
  belongs_to :game, inverse_of: :libraries
end
