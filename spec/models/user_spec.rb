# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  unique_email = 'unique@example.com'
  password = 'password'

  it 'is valid with valid attributes' do
    user = User.new(email: unique_email, password: password, password_confirmation: password)
    expect(user).to be_valid
  end

  it 'validates presence of email' do
    user = User.new(email: nil, password: password, password_confirmation: password)
    expect(user.valid?).to be_falsey
    expect(user.errors[:email]).to include("can't be blank")
  end

  it 'validates uniqueness of email' do
    create(:user, email: unique_email)
    user = User.new(email: unique_email, password: password, password_confirmation: password)
    expect(user.valid?).to be_falsey
    expect(user.errors[:email]).to include('has already been taken')
  end

  it 'validates presence of password' do
    user = User.new(email: unique_email, password: nil, password_confirmation: password)
    expect(user.valid?).to be_falsey
    expect(user.errors[:password]).to include("can't be blank")
  end

  it 'validates presence of password_confirmation' do
    user = User.new(email: unique_email, password: password, password_confirmation: nil)
    expect(user.valid?).to be_falsey
    expect(user.errors[:password_confirmation]).to include("can't be blank")
  end

  it 'validates that password matches password_confirmation' do
    user = User.new(email: unique_email, password: password, password_confirmation: 'notpassword')
    expect(user.valid?).to be_falsey
    expect(user.errors[:password]).to include('must match password confirmation')
  end
end
