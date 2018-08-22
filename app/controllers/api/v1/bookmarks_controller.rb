class Api::V1::BookmarksController < ApplicationController
  skip_before_action :authenticate_request, only: %i[login create]
  before_action :find_bookmark, only: [:update]

  def index
    @bookmarks = Bookmark.all
    render json: @bookmarks
  end

  def update
    @bookmark.update(bookmark_params)
    if @bookmark.save
      render json: @bookmark, status: :accepted
    else
      render json: { errors: @bookmark.errors.full_messages },  status: :unprocessible_entity
    end
  end

  def create
    @bookmark = Bookmark.find_or_create_by(bookmark_params)
    if @bookmark.save
      render json: @bookmark, status: :accepted
    else
      render json: { errors: @bookmark.errors.full_messages },  status: :unprocessible_entity
    end
  end

  def destroy
    @bookmark.delete
  end

  private

  def bookmark_params
    params.permit(:user_id, :article_id)
  end

  def find_bookmark
    @bookmark = Bookmark.find(params[:id])
  end
end
