class CategorySerializer
  include FastJsonapi::ObjectSerializer

  has_many :blogs

  attribute :name
end
