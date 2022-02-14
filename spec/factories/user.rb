# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    sequence(:username) { |i| "username#{i}" }
    password { 'user123qwE' }
  end
end
