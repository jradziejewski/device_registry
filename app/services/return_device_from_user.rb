# frozen_string_literal: true

class ReturnDeviceFromUser
  def initialize(requesting_user:, serial_number:, assigned_user_id:)
    @requesting_user = requesting_user
    @serial_number = serial_number
    @assigned_user_id = assigned_user_id
  end

  def call
    device = Device.find_by(serial_number: @serial_number)

    raise ReturnError::DeviceNotFound if device.nil?
    raise ReturnError::DeviceAlreadyReturned if device.user.nil?
    raise ReturnError::Unauthorized unless device.user.id == @assigned_user_id

    device.update!(user: nil)

    if device.save
      device.device_histories.create(user: @requesting_user)
      :success
    else
      :error
    end
  end
end
