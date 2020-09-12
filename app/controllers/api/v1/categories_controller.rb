class Api::V1::CategoriesController < ApplicationController
  before_action :set_category, only: [:show, :update, :destroy]

  def index
    categories = Category.all

    api_response(payload: CategorySerializer.new(categories))
  end

  def show
    api_response(payload: CategorySerializer.new(@category))
  end

  def create
    @category = Category.new(category_params)

    if @category.save
      api_response(payload: CategorySerializer.new(@category), status: :created)
    else
      api_error(title: 'Failed to create category', detail: @category.errors.full_messages.to_sentence, status: :unprocessable_entity)
    end
  end

  def update
    if @category.update(category_params)
      api_response(payload: CategorySerializer.new(@category))
    else
      api_error(title: 'Failed to update category', detail: @category.errors.full_messages.to_sentence, status: :unprocessable_entity)
    end
  end

  def destroy
    if @category.destroy
      api_success(message: 'Category was deleted successfully')
    else
      api_error(title: 'Failed to delete category', detail: @category.errors.full_messages.to_sentence, status: :unprocessable_entity)
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_category
      @category = Category.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def category_params
      params.require(:category).permit(:name)
    end
end
