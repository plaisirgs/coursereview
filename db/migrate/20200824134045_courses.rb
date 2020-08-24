class Courses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.string :professor
      t.string :title
      t.integer :rating
      t.integer :category_id
    end
  end
end
