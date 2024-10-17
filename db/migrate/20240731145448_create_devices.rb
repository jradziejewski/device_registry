# frozen_string_literal: true

class CreateDevices < ActiveRecord::Migration[7.1]
  def change
    create_table :devices do |t|
      t.string :serial_number, null: false
      t.references :user, foreign_key: true, null: true

      t.timestamps
    end

    add_index :devices, :serial_number, unique: true
  end
end
