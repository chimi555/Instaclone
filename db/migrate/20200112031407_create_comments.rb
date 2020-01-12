class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      t.text :content
      t.integer :user_id
      t.integer :micropost_id

      t.timestamps
    end
    add_index :comments, :user_id
    add_index :comments, :micropost_id
  end
end
