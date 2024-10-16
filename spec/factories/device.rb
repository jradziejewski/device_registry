# frozen_string_literal: true

FactoryBot.define do
  factory :device do
    sequence(:serial_number) { |n| n.to_s }
    association :user
  end
end
