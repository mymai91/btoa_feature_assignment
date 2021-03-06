# frozen_string_literal: true

class AddRoleToEmployee < ActiveRecord::Migration[5.1]
  def change
    add_reference :employees, :role, foreign_key: true
  end
end
