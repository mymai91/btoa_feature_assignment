require 'rails_helper'

describe Api::V1::IncomeController do
  describe "GET #index" do
    before(:each) do
      @c_google = create(:company)
      
      @sys_admin = create(:role)
      @manager = create(:role, :manager)
      @director = create(:role, :director)
      @staff = create(:role, :staff)
      
      @staff_1 = create(:employee, {company: @c_google, role_id: @staff.id})
      @staff_2 = create(:employee, {company: @c_google, role_id: @staff.id})
      @staff_3 = create(:employee, {company: @c_google, role_id: @staff.id})

      @income_1 = create(:income, {employee_id: @staff_1.id})
      @income_2 = create(:income, {employee_id: @staff_2.id})
      @income_3 = create(:income, {employee_id: @staff_3.id})

      # Create access scope
      create(:access_scope, {role_id: @manager.id})
      create(:access_scope, {role_id: @director.id, field_access: ['base_salary', 'overtime_payment']})

      @manager_keys_filter = ["base_salary", "employee_name", "id"]
      @director_keys_filter = ["base_salary", "employee_name", "id", "overtime_payment"]
    end

    context "should return a list of incomes limit by role" do
      
      it "with manager return success status and correct fields" do
        params = {"role_id"=> @manager.id, "company_id" => @c_google.id}
        
        get :index, params: params
        response_body = JSON.parse(@response.body)
        expect(response_body["incomes"].count).to eq(3)
        response_body["incomes"].each do |item|
          expect(item.keys.sort).to eq(@manager_keys_filter)
        end
        expect(@response).to have_http_status(:ok)
      end

      it "with director return success status and correct fields" do
        params = {"role_id"=> @director.id, "company_id" => @c_google.id}
        
        get :index, params: params
        
        response_body = JSON.parse(@response.body)
        expect(response_body["incomes"].count).to eq(3)
        response_body["incomes"].each do |item|
          expect(item.keys.sort).to eq(@director_keys_filter)
        end
       
        expect(@response).to have_http_status(:ok)
      end

      it "with sysadmin return success status and correct fields" do
        params = {"role_id"=> @sys_admin.id, "company_id" => @c_google.id}
        
        get :index, params: params
        
        response_body = JSON.parse(@response.body)
        expect(response_body["incomes"].count).to eq(0)
       
        expect(@response).to have_http_status(:ok)
      end

      it "with staff return success status and correct fields" do
        params = {"role_id"=> @staff.id, "company_id" => @c_google.id}
        
        get :index, params: params
        
        response_body = JSON.parse(@response.body)
        expect(response_body["incomes"].count).to eq(0)
       
        expect(@response).to have_http_status(:ok)
      end
    end
  end
end