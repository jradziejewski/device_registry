# frozen_string_literal: true

class DevicesController < ApplicationController
  before_action :authenticate_user!, only: %i[assign unassign]
  def assign
    AssignDeviceToUser.new(
      requesting_user: @current_user,
      serial_number: device_params[:serial_number],
      new_device_owner_id: device_params[:new_owner_id].to_i
    ).call
    head :ok
  rescue RegistrationError::Unauthorized => e
    render json: { error: e.message }, status: :unauthorized
  end

  def unassign
    # TODO: implement the unassign action
  end

  private

  def device_params
    params.permit(:new_owner_id, :serial_number)
  end
end
