# frozen_string_literal: true

class AddDetailsToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :url, :string
    add_column :users, :profile, :text
    add_column :users, :phone, :string
    add_column :users, :gender, :string
  end
end
