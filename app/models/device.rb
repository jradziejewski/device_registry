# frozen_string_literal: true

class Device < ApplicationRecord
  belongs_to :user, optional: true
  has_many :device_histories

  validates :serial_number, presence: true, uniqueness: true
end

class DeviceHistory < ApplicationRecord
  belongs_to :device
  belongs_to :user
end
