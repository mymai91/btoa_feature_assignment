# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

companies = [{name: "Google"}, {name: "Apple"}, {name: "Microsoft"}, {name: "Uber"}, {name: "Grab"}]

# Company.create(companies)

role_sysadmin = Role.create({name: "sysadmin"})
role_director = Role.create({name: "director"})
role_manager = Role.create({name: "manager"})
role_staff = Role.create({name: "staff"})

# Create sysadmin for each company
ranges = 1..5

companies.each_with_index do |company_item, com_index|
  company = Company.create(company_item)
  sysadmin = {
    last_name: "mr",
    first_name: "sysadmin",
    email: "sysadmin@#{company_item[:name].downcase}.com",
    company_id: company.id,
    role_id: role_sysadmin.id
  }

  director = {
    last_name: "mr",
    first_name: "director",
    email: "director@#{company_item[:name].downcase}.com",
    company_id: company.id,
    role_id: role_director.id
  }

  manager = {
    last_name: "mr",
    first_name: "manager",
    email: "manager@#{company_item[:name].downcase}.com",
    company_id: company.id,
    role_id: role_manager.id
  }

  ranges.each do |item|
    data = {
      last_name: "mr",
      first_name: "staff_#{item}",
      email: "staff_#{item}@#{company_item[:name].downcase}.com",
      company_id: company.id,
      role_id: role_staff.id
    }
    staff = Employee.create(data)
    data_income = {
      employee_id: staff.id,
      currency: 'SGD',
      base_salary: 1000 * item,
      overtime_payment: 1 * item,
      bonus: 100 * item,
      transport: 200 * com_index
    }
    Income.create(data_income)
  end

  Employee.create(sysadmin)
  Employee.create(director)
  Employee.create(manager)
  # Employee.create(staff)
end

# Permission
creatable = Permission.create(name: "creatable")
updatable = Permission.create(name: "updatable")
readable = Permission.create(name: "readable")
destroyable = Permission.create(name: "destroyable")

# role_permission
sysadmin_permission = [
  {
    role_id: role_sysadmin.id,
    permission_id: creatable.id
  },
  {
    role_id: role_sysadmin.id,
    permission_id: updatable.id
  },
  {
    role_id: role_sysadmin.id,
    permission_id: readable.id
  },
  {
    role_id: role_sysadmin.id,
    permission_id: destroyable.id
  }
]
RolePermission.create(sysadmin_permission)

director_permission = [
  {
    role_id: role_director.id,
    permission_id: creatable.id
  },
  {
    role_id: role_director.id,
    permission_id: updatable.id
  },
  {
    role_id: role_director.id,
    permission_id: readable.id
  },
  {
    role_id: role_director.id,
    permission_id: destroyable.id
  }
]
RolePermission.create(director_permission)

RolePermission.create({
  role_id: role_manager.id,
  permission_id: readable.id
})
