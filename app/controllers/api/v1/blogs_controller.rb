class Api::V1::BlogsController < ApplicationController
  before_action :set_blog, only: [:show, :update, :destroy]

  # GET /blogs
  def index
    blogs = Blog.all

    api_response(payload: BlogSerializer.new(blogs))
  end

  # GET /blogs/1
  def show
    api_response(payload: BlogSerializer.new(@blog))
  end

  # POST /users
  def create
    @blog = Blog.new(blog_params)

    if @blog.save
      api_response(payload: BlogSerializer.new(@blog), status: :created)
    else
      api_error(title: 'Failed to create blog', detail: @blog.errors.full_messages.to_sentence, status: :unprocessable_entity)
    end
  end

  # PATCH/PUT /users/1
  def update
    if @blog.update(blog_params)
      api_response(payload: BlogSerializer.new(@blog))
    else
      api_error(title: 'Failed to update blog', detail: @blog.errors.full_messages.to_sentence, status: :unprocessable_entity)
    end
  end

  # DELETE /users/1
  def destroy
    if @blog.destroy
      api_success(message: 'Blog was deleted successfully')
    else
      api_error(title: 'Failed to delete blog', detail: @blog.errors.full_messages.to_sentence, status: :unprocessable_entity)
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_blog
      @blog = Blog.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def blog_params
      params.require(:blog).permit(:user_id, :title, :body, :status, category_ids: [])
    end
end
