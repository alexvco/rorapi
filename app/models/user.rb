class User < ApplicationRecord
  # this is so that when i do User.first i get a User record and not an Author record
  # Note that you can still do Author.first, Member.all, etc... see Author and Member classes (default_scope)
  self.inheritance_column = :_type_disabled

  has_many :addresses
  has_many :blogs
  has_many :images, as: :imageable, class_name: 'Image', dependent: :destroy

  accepts_nested_attributes_for :addresses, allow_destroy: true
end
