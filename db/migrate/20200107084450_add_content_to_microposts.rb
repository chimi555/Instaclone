class AddContentToMicroposts < ActiveRecord::Migration[5.2]
  def change
    add_column :microposts, :content, :text
  end
end
