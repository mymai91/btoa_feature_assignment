# frozen_string_literal: true

class CreateIncomes < ActiveRecord::Migration[5.1]
  def change
    create_table :incomes do |t|
      t.references :employee, foreign_key: true
      t.string :currency
      t.bigint :base_salary
      t.bigint :overtime_payment
      t.bigint :bonus
      t.bigint :transport

      t.timestamps
    end
  end
end
