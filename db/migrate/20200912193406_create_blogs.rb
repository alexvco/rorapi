class CreateBlogs < ActiveRecord::Migration[5.1]
  def change
    create_table :blogs do |t|
      t.references :user, foreign_key: true
      t.string :title
      t.text :body
      t.integer :status

      t.timestamps
    end
  end
end
