class User < ApplicationRecord
  # this is so that when i do User.first i get a User record and not an Author record
  # Note that you can still do Author.first, Member.all, etc... see Author and Member classes (default_scope)
  self.inheritance_column = :_type_disabled

  has_many :addresses

  # you can't eagerly preload scopes, but you can do with associations
  # it's all made to reduce N+1 SQL requests
  # scope works for a single instance of an active record model
  # https://www.justinweiss.com/articles/how-to-preload-rails-scopes/
  # User.includes(:twenty_twenty_addresses).first(5) # will select the twenty_twenty_addresses of the first 5 users
  # and then you can iterate through each of the users twenty_twenty_addresses and "puts" the city for example without N + 1
  has_many :twenty_twenty_addresses, -> { Address.where("created_at > '2020-01-01' and created_at < '2020-12-31'") }, class_name: 'Address'

  has_many :blogs
  has_many :images, as: :imageable, class_name: 'Image', dependent: :destroy

  accepts_nested_attributes_for :addresses, allow_destroy: true
end
