# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Device, type: :model do
  let (:user) { create(:user) }

  it 'is valid with valid attributes' do
    device = Device.new(serial_number: '123456', user: user)
    expect(device).to be_valid
  end

  it 'validates presence of serial_number' do
    device = Device.new(serial_number: nil)
    expect(device.valid?).to be_falsey
    expect(device.errors[:serial_number]).to include("can't be blank")
  end

  it 'validates uniqueness of serial_number' do
    create(:device, serial_number: '123456')
    device = Device.new(serial_number: '123456')
    expect(device.valid?).to be_falsey
    expect(device.errors[:serial_number]).to include('has already been taken')
  end

  it 'belongs to a user' do
    device = Device.new(user: user)
    expect(device.user).to eq(user)
  end
end
