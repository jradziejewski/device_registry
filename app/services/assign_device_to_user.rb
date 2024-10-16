# frozen_string_literal: true

class AssignDeviceToUser
  def initialize(requesting_user:, serial_number:, new_device_owner_id:)
    @requesting_user = requesting_user
    @serial_number = serial_number
    @new_device_owner_id = new_device_owner_id
  end

  def call
    device = Device.find_by(serial_number: @serial_number)
    raise RegistrationError::Unauthorized if @requesting_user.id != @new_device_owner_id
  end
end
