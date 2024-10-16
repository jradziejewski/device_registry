class Device < ApplicationRecord
  belongs_to :user, optional: true
  has_many :device_histories
end

class DeviceHistory < ApplicationRecord
  belongs_to :device
  belongs_to :user
end