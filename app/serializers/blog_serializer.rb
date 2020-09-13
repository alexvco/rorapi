class BlogSerializer
  include FastJsonapi::ObjectSerializer

  has_many :images

  attributes :title, :body, :status
end
