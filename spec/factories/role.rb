# frozen_string_literal: true

FactoryBot.define do
  factory :role do
    name { 'sysadmin' }

    trait :director do
      name { 'director' }
    end

    trait :manager do
      name { 'manager' }
    end

    trait :staff do
      name { 'staff' }
    end
  end
end
