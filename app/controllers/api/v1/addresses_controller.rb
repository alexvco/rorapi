class Api::V1::AddressesController < ApplicationController
  before_action :set_address, only: [:show, :update, :destroy]

  def index
    addresses = Address.all

    api_response(payload: AddressSerializer.new(addresses))
  end

  def show
    api_response(payload: AddressSerializer.new(@address))
  end

  def create
    @address = Address.new(address_params)

    if @address.save
      api_response(payload: AddressSerializer.new(@address), status: :created)
    else
      api_error(title: 'Failed to create address', detail: @address.errors.full_messages.to_sentence, status: :unprocessable_entity)
    end
  end

  def update
    if @address.update(address_params)
      api_response(payload: AddressSerializer.new(@address))
    else
      api_error(title: 'Failed to update address', detail: @address.errors.full_messages.to_sentence, status: :unprocessable_entity)
    end
  end

  def destroy
    if @address.destroy
      api_success(message: 'Address was deleted successfully')
    else
      api_error(title: 'Failed to delete address', detail: @address.errors.full_messages.to_sentence, status: :unprocessable_entity)
    end
  end

  private
    def set_address
      @address = Address.find(params[:id])
    end

    def address_params
      params.require(:address).permit(:street, :city, :zip, :user_id)
    end
end
