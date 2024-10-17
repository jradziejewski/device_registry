# frozen_string_literal: true

class DevicesController < ApplicationController
  before_action :authenticate_user!, only: %i[assign unassign]
  def assign
    AssignDeviceToUser.new(
      requesting_user: @current_user,
      serial_number: device_params[:serial_number],
      new_device_owner_id: device_params[:target_user_id].to_i
    ).call
    head :ok
  rescue RegistrationError::Unauthorized => e
    render json: { error: e.message }, status: :unauthorized
  rescue AssigningError => e
    render json: { error: e.message }, status: :unprocessable_entity
  end

  def unassign
    ReturnDeviceFromUser.new(
      requesting_user: @current_user,
      serial_number: device_params[:serial_number],
      assigned_user_id: device_params[:target_user_id].to_i
    ).call
    head :ok
  rescue ReturnError::Unauthorized => e
    render json: { error: e.message }, status: :unauthorized
  rescue ReturnError => e
    render json: { error: e.message }, status: :unprocessable_entity
  end

  private

  def device_params
    params.permit(:serial_number, :target_user_id)
  end
end
