# frozen_string_literal: true

class Income < ApplicationRecord
  belongs_to :employee

  def self.search(params = {})
    incomes = params[:income_ids].present? ? Income.where(id: params[:income_ids]) : Income.all
    incomes = incomes.filter_by_company(params[company_id]) if params[:company_id]
    incomes
  end

  def self.filter_by_company(params)
    company_id = params[:company_id]
    fields = AccessScope.incomes(params[:role_id])
    results = []
    results = Income.joins(:employee).where(employees: { company_id: company_id }).select('id', 'employees.first_name as employee_name', fields) if fields.present?
    results
  end
end
