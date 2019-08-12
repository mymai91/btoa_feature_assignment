# frozen_string_literal: true

class InitSchema < ActiveRecord::Migration[5.1]
  def up
    create_table 'companies', force: :cascade, options: '' do |t|
      t.string 'name', default: '', null: false
      t.datetime 'created_at', default: -> { 'CURRENT_TIMESTAMP' }, null: false
      t.datetime 'updated_at', default: -> { 'CURRENT_TIMESTAMP' }, null: false
    end

    create_table 'employees', force: :cascade, options: '' do |t|
      t.string 'last_name', default: '', null: false
      t.string 'first_name', default: '', null: false
      t.string 'email', default: '', null: false
      t.integer 'gender', limit: 1, default: 0, null: false
      t.bigint 'company_id', null: false
      t.datetime 'created_at', default: -> { 'CURRENT_TIMESTAMP' }, null: false
      t.datetime 'updated_at', default: -> { 'CURRENT_TIMESTAMP' }, null: false
      t.index ['company_id'], name: 'index_employees_on_company_id'
    end

    create_table 'roles', options: '', force: :cascade do |t|
      t.string 'name'
      t.string 'resource_type'
      t.bigint 'resource_id'
      t.datetime 'created_at', null: false
      t.datetime 'updated_at', null: false
      t.index %w[name resource_type resource_id], name: 'index_roles_on_name_and_resource_type_and_resource_id'
      t.index ['name'], name: 'index_roles_on_name'
      t.index %w[resource_type resource_id], name: 'index_roles_on_resource_type_and_resource_id'
    end
  end

  def down
    raise ActiveRecord::IrreversibleMigration, 'The initial migration is not revertable'
  end
end
