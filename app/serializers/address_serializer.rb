class AddressSerializer
  include FastJsonapi::ObjectSerializer

  attributes :street, :city, :zip
end
