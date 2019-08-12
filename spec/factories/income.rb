# frozen_string_literal: true

FactoryBot.define do
  factory :income do
    currency { 'SGD' }
    base_salary { 1000 }
    overtime_payment { 2 }
    bonus { 100 }
    transport { 200 }
  end
end
