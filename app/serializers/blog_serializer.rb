class BlogSerializer
  include FastJsonapi::ObjectSerializer

  has_many :images
  has_many :categories

  attributes :title, :body, :status

  # this will make it an attribute of blog data as opposed to the 'included' section/hash of the response
  # the has_many :categories above is a better solution as categories is an associated model and should belong under included
  #
  # attribute :categories do |blog|
  #   blog.categories.map do |category|
  #     {
  #       id: category.id,
  #       name: category.name
  #     }
  #   end
  # end
end
