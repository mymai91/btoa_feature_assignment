# RESULT

### Prepared

- Upgraded sqlite3 to pg database 

- install npm package

### Tech stacks

**Backend**
- rails
- rspec

**Front end**
- ReactJS
- Ant Design Library

### How to run

#### Setup the database

```
rails db:drop db:create db:migrate db:seed
```

#### Run rails server

```
  rails s
```

#### Run web pack server

```
  ./bin/webpack-dev-server
```

### Run Test cases

```
  rspec
```

#### Images describe

**Setting**

> User can select IAM

> From the company

> Click on View Button to see the result

<img width="1524" alt="Screenshot 2019-08-12 at 9 48 57 PM" src="https://user-images.githubusercontent.com/6791942/62869868-2c9a0900-bd4b-11e9-86b1-5052fc8ff587.png">

**Setting Result**

<img width="1483" alt="BtoaFeatureAssignments" src="https://user-images.githubusercontent.com/6791942/62870162-b77b0380-bd4b-11e9-9358-2d532c8bbd1e.png">

**Manage setting**

> Select table to setting

<img width="1484" alt="Screenshot 2019-08-12 at 9 55 46 PM" src="https://user-images.githubusercontent.com/6791942/62870286-fc9f3580-bd4b-11e9-8f07-1499681dfec1.png">

> Multiple setting

<img width="1477" alt="BtoaFeatureAssignments" src="https://user-images.githubusercontent.com/6791942/62870403-2b1d1080-bd4c-11e9-96e6-c289d69c56d9.png">

> Successful notification

<img width="1532" alt="Screenshot 2019-08-12 at 9 59 05 PM" src="https://user-images.githubusercontent.com/6791942/62870552-6ddee880-bd4c-11e9-81d0-4db6af683f8e.png">

> No permissions to manage setting

<img width="1519" alt="Screenshot 2019-08-12 at 10 01 08 PM" src="https://user-images.githubusercontent.com/6791942/62870727-b5657480-bd4c-11e9-99b4-9136541be9ba.png">

### Pros and Cons

#### Pros

- The controller is testable and the methods, functions are easy to read
- Flexible UI design
- Initialize seed db

#### Cons

- Within 2 days I haven't finished 4 cases BUT my approach solves for the whole situation
- There are no setting for authorization
