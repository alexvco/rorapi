class Api::V1::UsersController < ApplicationController
  before_action :set_user, only: [:show, :update, :destroy]

  # GET /users
  def index
    users = User.all

    api_response(payload: UserSerializer.new(users))
  end

  # GET /users/1
  def show
    api_response(payload: UserSerializer.new(@user, show_options))
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

    def show_options
      {
        include: [:blogs, :"blogs.images"],
        fields: {
          user: [:first_name, :last_name, :blogs],
          blog: [:title, :images],
          image: [:filename]
        }
      }
    end

    # the show_options will return the following (example):
    # I wrapped it in a method that never gets called to keep syntax highlighting as opposed to commented out
    def example_result
      {
          "data": {
              "id": "1",
              "type": "user",
              "attributes": {
                  "first_name": "test",
                  "last_name": "jones"
              },
              "relationships": {
                  "blogs": {
                      "data": [
                          {
                              "id": "1",
                              "type": "blog"
                          },
                          {
                              "id": "3",
                              "type": "blog"
                          }
                      ]
                  }
              }
          },
          "included": [
              {
                  "id": "1",
                  "type": "blog",
                  "attributes": {
                      "title": "Blog 1"
                  },
                  "relationships": {
                      "images": {
                          "data": [
                              {
                                  "id": "4",
                                  "type": "image"
                              },
                              {
                                  "id": "3",
                                  "type": "image"
                              }
                          ]
                      }
                  }
              },
              {
                  "id": "3",
                  "type": "blog",
                  "attributes": {
                      "title": "another blog 1"
                  },
                  "relationships": {
                      "images": {
                          "data": [
                              {
                                  "id": "5",
                                  "type": "image"
                              }
                          ]
                      }
                  }
              },
              {
                  "id": "4",
                  "type": "image",
                  "attributes": {
                      "filename": "ghg"
                  }
              },
              {
                  "id": "3",
                  "type": "image",
                  "attributes": {
                      "filename": "ii"
                  }
              },
              {
                  "id": "5",
                  "type": "image",
                  "attributes": {
                      "filename": "rty"
                  }
              }
          ]
      }
    end
end
