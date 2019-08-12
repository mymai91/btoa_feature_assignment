# frozen_string_literal: true

require 'rails_helper'

describe Api::V1::SettingController do
  describe 'GET #info' do
    before(:each) do
      @c_google = create(:company)
      @c_apple = create(:company, :apple)

      @sys_admin = create(:role)
      @manager = create(:role, :manager)
      @director = create(:role, :director)
      @staff = create(:role, :staff)

      @permission_creatable = create(:permission)
      @sys_admin.permissions = [@permission_creatable]
    end

    it 'should return a object include roles and companies' do
      get :info

      response_body = JSON.parse(@response.body)
      expect(response_body['roles'].count).to eq(4)
      expect(response_body['companies'].count).to eq(2)
      expect(@response).to have_http_status(:ok)
    end

    it 'should return a object include roles, table_fields, list_table and companies' do
      get :manage_table

      expect_fields = ["list_table", "roles", "table_fields"]
      response_body = JSON.parse(@response.body)
      expect(response_body['roles'].count).to eq(4)
      expect(response_body.keys.sort).to eq(expect_fields)
      expect(@response).to have_http_status(:ok)
    end

    describe 'POST #access_scope' do
      context "with permission access scope" do
        it 'create new access scope if there is no access scope base on role and table' do
          params = { 'iam_id'=> @sys_admin.id, 'role_id' => @manager.id, 'table_name' => 'incomes', 'field_access': ['base_salary'] }
          access_scope = AccessScope.all.count
          post :access_scope, params: params
          
          access_scope_created = AccessScope.all.count

          expect(access_scope + 1).to eq(access_scope_created)
          expect(@response).to have_http_status(:created)
        end

        it 'update new access scope if there is an access scope base on role and table' do
          create(:access_scope, role_id: @manager.id)
          access_scope = AccessScope.all.count
          params = { 'iam_id'=> @sys_admin.id, 'role_id' => @manager.id, 'table_name' => 'incomes', 'field_access': ['base_salary'] }
          post :access_scope, params: params

          access_scope_created = AccessScope.all.count
          expect(access_scope).to eq(access_scope_created)
          expect(@response).to have_http_status(:created)
        end
      end

      context "without permission" do
        it 'throw error' do
          params = { 'iam_id'=> @manager.id, 'role_id' => @manager.id, 'table_name' => 'incomes', 'field_access': ['base_salary'] }
          post :access_scope, params: params
          
          expect(@response).to have_http_status(403)
        end
      end
    end
  end
end
