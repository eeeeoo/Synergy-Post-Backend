class Api::V1::UsersController < ApplicationController
  skip_before_action :authenticate_request, only: %i[login create]
  before_action :find_user, only: [:update, :index]

  # def index
  #   @users = User.all
  #   render json: @users
  # end

  def index
    render json: @user
  end
  #
  # def show
  #   render json: @user
  # end

  def update
    @user.update(user_params)
    if @user.save
      render json: @user, status: :accepted
    else
      render json: { errors: @user.errors.full_messages },  status: :unprocessible_entity
    end
  end

  def create
    @user = User.create(user_params)
    if @user.save
      render json: @user, status: :accepted
    else
      render json: { errors: @user.errors.full_messages },  status: :unprocessible_entity
    end
  end

  def destroy
    @user.delete
  end

  def login
    authenticate params[:email], params[:password]
  end

  def authenticate(email, password)
    command = AuthenticateUser.call(email, password)

    if command.success?
      render json: {
        access_token: command.result,
        message: 'Login Successful',
      }
    else
      render json: { error: command.errors }, status: :unauthorized
    end
   end

  def user_params
    params.permit(
      :name,
      :email,
      :password
    )
  end

  def find_user
    @user = current_user
  end
end
