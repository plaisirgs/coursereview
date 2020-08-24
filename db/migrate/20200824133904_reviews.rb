class Reviews < ActiveRecord::Migration
  def change
      create_table :reviews do |t|
      t.string :text
      t.integer :user_id
      t.integer :course_id
    end
  end
end
