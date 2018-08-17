class BookmarkSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :article_id

  belongs_to :user
  belongs_to :article
end
