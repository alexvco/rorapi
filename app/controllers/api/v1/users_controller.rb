class Api::V1::UsersController < ApplicationController
  before_action :set_user, only: [:show, :update, :destroy]

  # GET /users
  def index
    users = User.all

    api_response(payload: UserSerializer.new(users))
  end

  # GET /users/1
  def show
    api_response(payload: UserSerializer.new(@user))
  end

  # POST /users
  def create
    @user = User.new(user_params)

    if @user.save
      api_response(payload: UserSerializer.new(@user), status: :created)
    else
      api_error(title: 'Failed to create user', detail: @user.errors.full_messages.to_sentence, status: :unprocessable_entity)
    end
  end

  # PATCH/PUT /users/1
  def update
    if @user.update(user_params)
      api_response(payload: UserSerializer.new(@user))
    else
      api_error(title: 'Failed to update user', detail: @user.errors.full_messages.to_sentence, status: :unprocessable_entity)
    end
  end

  # DELETE /users/1
  def destroy
    if @user.destroy
      api_success(message: 'User was deleted successfully')
    else
      api_error(title: 'Failed to delete user', detail: @user.errors.full_messages.to_sentence, status: :unprocessable_entity)
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def user_params
      # You can disguise your inherited model to it's parent before the permit action
      if params.has_key? :member
        params[:user] = params.delete :member
      elsif params.has_key? :author
        params[:user] = params.delete :author
      end

      params.require(:user).permit(:email, :type, :first_name, :last_name)
    end
end
