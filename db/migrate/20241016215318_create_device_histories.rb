class CreateDeviceHistories < ActiveRecord::Migration[7.1]
  def change
    create_table :device_histories do |t|
      t.references :device, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
