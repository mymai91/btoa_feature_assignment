## Coding Assignment

### Purpose
We dont judge the correctness of your solutions.
We want to see how you architect your app, and what your coding style is.

### Contents

We want to set permissions dynamically to each role for any `attributes`, `objects`, `classes`.
Then through out our system we can easily check user's permissions by refering to their roles.

We have 4 permissions as Creatable/Updatable/Readable/Destroyable

We have 4 roles
- sysadmin/director by default has full permissions.
- Manager by default can only Readable
- Staff by default has no permissions

### requirements

We want you to solve these cases:

1. Limit access of Manager to base allowances data:

  Each employee has many base allowances, 1 base allowance includes these attributes base_salary, overtime_payment, bonus, transport. Manager can only see base_salary.
  
 2. Limit access of Manager to Survey:

  Users are allowed to create survey freely, each survey has some questions. For example, SurveyA will have question1 and question2. Now that user want the Manager can only see the question1.
  
3. Limit access of Manager to Setting page:
  
  We have a setting page where includes various confidential settings, our users want to allow the Manager to have access to only some pages. For example, we have `employee pages`, `Credit card pages`, then Managers can only see `employee pages`.
  

### Bonus points
- Doing proper error handling, adding unit tests, and commenting your code.
- Add TODOs and FIXMEs in places where you cut a corner for expediency but know a production ready version would need refactoring, additional tests or handling of certain edge cases that you know or suspect to exist but don't handle yet.

### NOTE
- We prepared for you models: company, employee, role.
- Please CLONE this repo, implement and create your OWN REPO FOR SUBMISSION, send us the link to your repo. DO NOT CREATE PULL REQUEST TO THIS REPO.

