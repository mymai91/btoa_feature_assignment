module Api::V1
  class IncomeController < ApplicationController
    include ApplicationHelper

    def index
      incomes = Income.filter_by_company(income_params)
      render json: {
        incomes: incomes,
      }, status: :ok
    end

    private

    def income_params
      {
        role_id: params["role_id"],
        company_id: params["company_id"]
      }
    end
  end
end