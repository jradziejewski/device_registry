# frozen_string_literal: true

class User < ApplicationRecord
  has_many :devices
  has_many :api_keys, as: :bearer
  has_secure_password

  validates :email, presence: true, uniqueness: true
  validates :password, presence: true
  validates :password_confirmation, presence: true, if: -> { password.present? }

  validate :passwords_must_match

  private

  def passwords_must_match
    errors.add(:password, 'must match password confirmation') unless password == password_confirmation
  end
end
