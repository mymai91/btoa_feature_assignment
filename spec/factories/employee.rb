# frozen_string_literal: true

FactoryBot.define do
  factory :employee do
    last_name { 'mr' }
    first_name { 'staff' }
    email { 'staff@google.com' }
  end
end
