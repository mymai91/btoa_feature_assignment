# frozen_string_literal: true

class AccessScope < ApplicationRecord
  belongs_to :role

  def self.filter_field_access(params = {})
    result = find_by(params)

    result&.field_access
  end

  def self.incomes(role_id)
    filter_field_access(role_id: role_id, table_name: 'incomes')
  end

  def self.add_scope(params)
    if Role.check_permission?(params[:iam_id], 'creatable')
      params = params.except(:iam_id)
      result = find_by(role_id: params[:role_id], table_name: params[:table_name])
      result.nil? ? create(params) : result.update(params)
    else
      nil
    end
  end
end
