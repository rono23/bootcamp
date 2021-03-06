# frozen_string_literal: true

class AddIndexToWorks < ActiveRecord::Migration[6.0]
  def change
    add_index :works, %i[user_id title], unique: true
  end
end
