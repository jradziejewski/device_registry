# frozen_string_literal: true

class CreateApiKeys < ActiveRecord::Migration[7.1]
  def change
    create_table :api_keys do |t|
      t.integer :bearer_id, null: false
      t.string :bearer_type, null: false
      t.string :token, null: false
      t.timestamps null: false
    end

    add_index :api_keys, %i[bearer_id bearer_type]
    add_index :api_keys, :token, unique: true
  end
end
