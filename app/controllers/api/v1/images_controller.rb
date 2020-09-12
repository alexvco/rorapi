class Api::V1::ImagesController < ApplicationController
  before_action :set_image, only: [:show, :update, :destroy]

  # GET /images
  def index
    images = Image.all

    api_response(payload: ImageSerializer.new(images))
  end

  # GET /images/1
  def show
    api_response(payload: ImageSerializer.new(@image))
  end

  # POST /users
  def create
    @image = Image.new(image_params)

    if @image.save
      api_response(payload: ImageSerializer.new(@image), status: :created)
    else
      api_error(title: 'Failed to create image', detail: @image.errors.full_messages.to_sentence, status: :unprocessable_entity)
    end
  end

  # PATCH/PUT /users/1
  def update
    if @image.update(image_params)
      api_response(payload: ImageSerializer.new(@image))
    else
      api_error(title: 'Failed to update image', detail: @image.errors.full_messages.to_sentence, status: :unprocessable_entity)
    end
  end

  # DELETE /users/1
  def destroy
    if @image.destroy
      api_success(message: 'Image was deleted successfully')
    else
      api_error(title: 'Failed to delete image', detail: @image.errors.full_messages.to_sentence, status: :unprocessable_entity)
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_image
      @image = Image.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def image_params
      params.require(:image).permit(:filename, :imageable_id, :imageable_type)
    end
end
