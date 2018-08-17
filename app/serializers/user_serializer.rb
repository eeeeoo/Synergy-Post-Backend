class UserSerializer < ActiveModel::Serializer
  attributes :id, :name

  has_many :bookmarks
  has_many :articles, through: :bookmarks
end
