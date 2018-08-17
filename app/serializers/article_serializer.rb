class ArticleSerializer < ActiveModel::Serializer
  attributes :id, :title, :content, :author, :url, :urlToImage, :sourceId, :sourceName, :publishedAt

  has_many :bookmarks
  has_many :users, through: :bookmarks
end
