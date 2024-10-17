# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ReturnDeviceFromUser do
  subject(:return_device) do
    described_class.new(
      requesting_user: user,
      serial_number: serial_number,
      assigned_user_id: assigned_user_id
    ).call
  end

  example_serial = '234567'

  let(:user) { create(:user) }
  let(:assigned_user_id) { user.id }
  let(:serial_number) { example_serial }
  let!(:device) { Device.create(serial_number: example_serial, user: user) }

  context 'when user tries to return a device they do not own' do
    let(:other_user) { create(:user, email: 'other_user@example.com') }
    let(:assigned_user_id) { other_user.id }

    it 'raises an unauthorized error' do
      expect { return_device }.to raise_error(ReturnError::Unauthorized)
    end
  end

  context 'when user returns a device they own' do
    it 'successfully returns the device' do
      expect { return_device }.to change { device.reload.user }.from(user).to(nil)
      expect(return_device).to eq(:success)
    end

    it 'creates a new entry in history' do
      expect { return_device }.to change { DeviceHistory.count }.by(1)

      history = DeviceHistory.last
      expect(history.device.serial_number).to eq(serial_number)
      expect(history.user).to eq(user)
    end
  end

  context 'when the user tries to return device that is already returned' do
    before do
      device.update!(user: nil)
    end

    it 'raises an already returned error' do
      expect { return_device }.to raise_error(ReturnError::DeviceAlreadyReturned)
    end
  end

  context 'when the device with given serial does not exist' do
    let(:serial_number) { 'non_existent_serial' }

    it 'raises an unauthorized error' do
      expect { return_device }.to raise_error(ReturnError::DeviceNotFound)
    end
  end
end
