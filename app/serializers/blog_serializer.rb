class BlogSerializer
  include FastJsonapi::ObjectSerializer

  attributes :title, :body, :status
end
