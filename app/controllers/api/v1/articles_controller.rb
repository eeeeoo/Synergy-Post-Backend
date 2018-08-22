class Api::V1::ArticlesController < ApplicationController
  skip_before_action :authenticate_request, only: %i[login create]
  before_action :find_article, only: [:update]

  def index
    @articles = Article.all
    render json: @articles
  end

  def update
    @article.update(article_params)
    if @article.save
      render json: @article, status: :accepted
    else
      render json: { errors: @article.errors.full_messages },  status: :unprocessible_entity
    end
  end

  def create
    @article = Article.find_or_create_by(article_params)
    if @article.save
      render json: @article, status: :accepted
    else
      render json: { errors: @article.errors.full_messages },  status: :unprocessible_entity
    end
  end

  def destroy
    @article.delete
  end



  def article_params
    params.permit(:title, :content, :author, :url, :urlToImage, :sourceId, :sourceName, :publishedAt)
  end

  def find_article
    @article = Article.find(params[:id])
  end
end
