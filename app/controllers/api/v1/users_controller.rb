class Api::V1::UsersController < ApplicationController
  before_action :find_user, only: [:update]
    def index
      @users = User.all
      render json: @users
  end

  def update

    @user.update(user_params)
    if @user.save
      render json: @user, status: :accepted
    else
      render json: { errors: @user.errors.full_messages },  status: :unprocessible_entity
    end
  end

  private

  def note_params
    params.permit(:name)
  end

  def find_note
    @user = User.find(params[:id])
  end
end
