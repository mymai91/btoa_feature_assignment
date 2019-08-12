# frozen_string_literal: true

module Api::V1
  class SettingController < ApplicationController
    skip_before_action :verify_authenticity_token

    include ApplicationHelper
    def info
      @roles = Role.get_all
      @companies = Company.get_all

      render json: {
        roles: transform_roles,
        companies: transform_companies
      }, status: :ok
    end

    def manage_table
      @roles = Role.get_all

      render json: {
        roles: transform_roles,
        table_fields: table_columns,
        list_table: list_table
      }, status: :ok
    end

    def access_scope
      AccessScope.add_scope(manage_params)
      
      render json: {
        message: 'updated new access scope'
      }, status: :created
    end

    private

    def list_table
      ActiveRecord::Base.connection.tables
    end

    def table_columns
      tables = {}
      list_table.each do |table_name|
        tables[table_name] = ActiveRecord::Base.connection.columns(table_name).map(&:name)
      end
      tables
    end

    def transform_roles
      serialize_fields(@roles)
    end

    def transform_companies
      serialize_fields(@companies)
    end

    def manage_params
      {
        role_id: params[:role_id],
        table_name: params[:table_name],
        field_access: params[:field_access]
      }
    end
  end
end
