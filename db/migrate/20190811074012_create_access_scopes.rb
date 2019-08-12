class CreateAccessScopes < ActiveRecord::Migration[5.1]
  def change
    create_table :access_scopes do |t|
      t.references :role, foreign_key: true
      t.string :table_name
      t.string :field_access, array: true

      t.timestamps
    end
  end
end
