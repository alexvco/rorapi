class UserSerializer
  include FastJsonapi::ObjectSerializer

  has_many :blogs # this will add the relationships hash

  attributes :first_name, :last_name, :email, :type

  attribute :full_name do |user|
    "#{user.first_name} #{user.last_name}"
  end
end