# frozen_string_literal: true

FactoryBot.define do
  factory :company do
    name { 'Google' }

    trait :apple do
      name { 'Apple' }
    end

    trait :microsoft do
      name { 'Microsoft' }
    end

    trait :uber do
      name { 'Uber' }
    end

    trait :grab do
      name { 'Grab' }
    end
  end
end
