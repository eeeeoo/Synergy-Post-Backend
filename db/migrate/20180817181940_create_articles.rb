class CreateArticles < ActiveRecord::Migration[5.2]
  def change
    create_table :articles do |t|
      t.string :title
      t.string :content
      t.string :author
      t.string :url
      t.string :urlToImage
      t.string :sourceId
      t.string :sourceName
      t.datetime :publishedAt

      t.timestamps
    end
  end
end
