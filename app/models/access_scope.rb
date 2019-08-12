class AccessScope < ApplicationRecord
  belongs_to :role

  def self.filter_field_access(params = {})
    result = self.find_by(params)

    result.field_access unless result.nil?
  end

  def self.incomes(role_id)
    self.filter_field_access({role_id: role_id, table_name: 'incomes'})
  end

  def self.add_scope(params)
    result = self.find_by({role_id: params[:role_id], table_name: params[:table_name]})
    if result.nil?
      self.create(params)
    else
      result.update(params)
    end
  end
end
