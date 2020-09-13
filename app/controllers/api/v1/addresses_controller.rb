class Api::V1::AddressesController < ApplicationController
  before_action :set_address, only: [:show, :update, :destroy]

  def index
    puts 'x' * 400
    puts address_params.keys.first.class
    puts 'x' * 400
    addresses = Address.all

    api_response(payload: AddressSerializer.new(addresses))
  end

  def show
    api_response(payload: AddressSerializer.new(@address, show_options(params)))
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

    def show_options(params)
      # if you just want to return specific fields of address (ie: street, city)
      # as opposed to all the default attributes returned by the AddressSerializer
      # you can make a request like this: http://localhost:3000/api/v1/addresses/1?address_fields=street,city
      address_fields = params.dig(:address_fields)&.split(',')
      address_fields = nil unless address_fields&.all? {|field| address_params.keys.include?(field)} # this is just for safety so that they can request only permitted fields
      {
        fields: { 
          address: address_fields.present? ? address_fields : %i[street city zip] 
        }
      }
    end
end
