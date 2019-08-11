# frozen_string_literal: true

class Role < ApplicationRecord
  scopify

  ROLES = %w[
    sysadmin
    director
    general_manager
    manager
    staff
    employee
  ].freeze

  has_and_belongs_to_many :employees, join_table: :employees_roles
  belongs_to :resource, polymorphic: true, optional: true
  
  has_many :role_permissions
  has_many :permissions, through: :role_permissions

  validates :resource_type,
            inclusion: { in: Rolify.resource_types },
            allow_nil: true
  validates :name, inclusion: { in: ROLES }, presence: true

  def self.get_all
    self.all
  end
end
