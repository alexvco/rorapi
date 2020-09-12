class UserSerializer
  include FastJsonapi::ObjectSerializer

  attributes :first_name, :last_name, :email, :type

  attribute :full_name do |user|
    "#{user.first_name} #{user.last_name}"
  end
end