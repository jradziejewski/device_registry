# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AssignDeviceToUser do
  subject(:assign_device) do
    described_class.new(
      requesting_user: user,
      serial_number: serial_number,
      new_device_owner_id: new_device_owner_id
    ).call
  end

  let(:user) { create(:user) }
  let(:serial_number) { '123456' }

  context 'when users registers a device to other user' do
    let(:new_device_owner_id) { create(:user, email: 'other_user@example.com').id }

    it 'raises an error' do
      expect { assign_device }.to raise_error(RegistrationError::Unauthorized)
    end
  end

  context 'when user registers a device on self' do
    let(:new_device_owner_id) { user.id }

    it 'creates a new device' do
      assign_device

      expect(user.devices.pluck(:serial_number)).to include(serial_number)
    end

    it 'creates a new entry in history' do
      expect { assign_device }.to change { DeviceHistory.count }.by(1)

      history = DeviceHistory.last
      expect(history.device.serial_number).to eq(serial_number)
      expect(history.user).to eq(user)
    end

    context 'when a user tries to register a device that was already assigned to and returned by the same user' do
      before do
        AssignDeviceToUser.new(
          requesting_user: user,
          serial_number: serial_number,
          new_device_owner_id: user.id
        ).call
        ReturnDeviceFromUser.new(requesting_user: user, serial_number: serial_number, assigned_user_id: user.id).call
      end
      it 'does not allow to register' do
        expect { assign_device }.to raise_error(AssigningError::AlreadyUsedOnUser)
      end
    end

    context 'when user tries to register device that is already assigned to other user' do
      let(:other_user) { create(:user, email: 'other_user@example.com') }

      before do
        AssignDeviceToUser.new(
          requesting_user: other_user,
          serial_number: serial_number,
          new_device_owner_id: other_user.id
        ).call
      end

      it 'does not allow to register' do
        expect { assign_device }.to raise_error(AssigningError::AlreadyUsedOnOtherUser)
      end
    end
  end
end
