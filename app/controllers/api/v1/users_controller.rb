class Api::V1::UsersController < ApplicationController
  skip_before_action :authenticate_request, only: %i[login create]
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

  # POST /register
  # def create
  #   @user = User.find_or_create_by(user_params)
  #  if @user.save
  #   response = { message: 'User created successfully'}
  #   render json: response, status: :created
  #  else
  #   render json: @user.errors, status: :bad
  #  end
  # end

  def login
    authenticate params[:email], params[:password]
  end


  def authenticate(email, password)
    command = AuthenticateUser.call(email, password)

    if command.success?
      render json: {
        access_token: command.result,
        message: 'Login Successful'
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
    @user = User.find(params[:id])
  end
end
