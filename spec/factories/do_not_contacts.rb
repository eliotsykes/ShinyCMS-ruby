# frozen_string_literal: true

FactoryBot.define do
  factory :do_not_contact do
    email { Faker::Internet.unique.email }
  end
end
