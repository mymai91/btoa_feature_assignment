# frozen_string_literal: true

FactoryBot.define do
  factory :access_scope do
    table_name { 'incomes' }
    field_access { ['base_salary'] }
  end
end
