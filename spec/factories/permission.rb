# frozen_string_literal: true

FactoryBot.define do
  factory :permission do
    name { 'creatable' }

    trait :updatable do
      name { 'updatable' }
    end

    trait :microsoft do
      name { 'Microsoft' }
    end

    trait :readable do
      name { 'readable' }
    end

    trait :destroyable do
      name { 'destroyable' }
    end
  end
end
