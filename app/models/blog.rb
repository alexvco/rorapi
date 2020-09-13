class Blog < ApplicationRecord
  belongs_to :author, foreign_key: :user_id, class_name: 'Author'
  has_many :images, as: :imageable, class_name: 'Image', dependent: :destroy
  has_and_belongs_to_many :categories, join_table: :blogs_categories

  enum status: { Private: 0, Paid: 1, Public: 2 }

  validate :has_at_least_one_category

  # Note that since status is an enum, Rails has already defined the method below with: Blog.Public
  # scope :public, -> { where(status: 2) }

  scope :first_ten, -> { first(10) }
  scope :id_greater_than, -> (id) { where('id > ?', id) }

  def has_at_least_one_category
    if categories.empty?
      errors.add(:categories, "need one category at least")
    end
  end

  def self.id_less_than(id)
    self.where('id < ?', id)
    # => #<ActiveRecord::Relation [#<Blog id: 2, user_id: 1, title: "public blog title 2", body: "body of public blog 2", status: "Private", created_at: "2020-08-01 02:41:19", updated_at: "2020-08-05 06:49:03">]>

    # Blog.find_by_sql('select * from blogs where id < 3')
    # => [#<Blog id: 2, user_id: 1, title: "public blog title 2", body: "body of public blog 2", status: "Private", created_at: "2020-08-01 02:41:19", updated_at: "2020-08-05 06:49:03">]

    # ActiveRecord::Base.connection.execute('select * from blogs where id < 3')
    # => #<PG::Result:0x00007fdecf068690 status=PGRES_TUPLES_OK ntuples=1 nfields=7 cmd_tuples=1>

    # ActiveRecord::Base.connection.execute('select * from blogs where id < 3').to_a
    # => [{"id"=>2, "user_id"=>1, "title"=>"public blog title 2", "body"=>"body of public blog 2", "status"=>0, "created_at"=>2020-08-01 02:41:19 UTC, "updated_at"=>2020-08-05 06:49:03 UTC}]
  end

end
