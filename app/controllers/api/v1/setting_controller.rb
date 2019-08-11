module Api::V1
  class SettingController < ApplicationController
    include ApplicationHelper
    def info
      @roles = Role.get_all
      @companies = Company.get_all

      # ActiveModelSerializers::SerializableResource.new(@roles.to_a).to_json 
      
      # ApplicationHelper.serialize_fields(@companies)

      render json: {
        roles: transform_roles,
        companies: transform_companies
      }, status: :ok
    end

    private

    def transform_roles
      serialize_fields(@roles)
    end

    def transform_companies
      serialize_fields(@companies)
    end
  end
end