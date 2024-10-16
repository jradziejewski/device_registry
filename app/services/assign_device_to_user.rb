# frozen_string_literal: true

class AssignDeviceToUser
  def initialize(requesting_user:, serial_number:, new_device_owner_id:)
    @requesting_user = requesting_user
    @serial_number = serial_number
    @new_device_owner_id = new_device_owner_id
  end

  def call
    raise RegistrationError::Unauthorized if @requesting_user.id != @new_device_owner_id

    device = Device.find_or_initialize_by(serial_number: @serial_number)

    raise AssigningError::AlreadyUsedOnUser if device.device_histories.where(user_id: @requesting_user.id).exists?
    raise AssigningError::AlreadyUsedOnOtherUser if device.user && device.user != @requesting_user

    device.user = @requesting_user

    if device.save
      device.device_histories.create(user: @requesting_user)
      :success
    else
      :error
    end
  end
end
