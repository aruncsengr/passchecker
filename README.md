# Passchecker
An online portal to validate passwords.

## Table of Contents
* [General Information](#general-information)
* [Technologies Used](#technologies-used)
* [Setup](#setup)
* [Usage](#usage)
* [Automated test runner](#automated-test-runner)

## General Information
Passchecker is an online platform to perform password validations by bulk user data import.


## Technologies Used
- Ruby - 3.1.2
- Rails - 7.0.8.4
- PostgreSQL

## Setup

Install it using below steps:

```
$ git clone https://github.com/aruncsengr/passchecker.git
$ rvm use ruby-3.1.2@passchecker --create
$ cd passchecker
$ bundle
$ rake db:create
$ rake db:migrate
```

## Usage

**To kickstart app**

```
$ rails s -p 3000
```

## Automated test runner

**To run all test cases**

```
$ rspec --format documentation
```
which results
```
User
  is expected to have db column named name
  is expected to have db column named password
  validations
    is expected to validate that :name cannot be empty/falsy
    is expected to validate that :password cannot be empty/falsy
    is expected to validate that the length of :password is between 10 and 16
    when password with sequential 3 chars
      is expected to be invalid
    when password with non-sequential 3 chars
      is expected to be valid

Users
  GET /index
    returns http success
  POST /import
    with no file
      returns http status - 302
    with invalid file
      returns http status - 302
    with valid file
      returns http status - success

CsvImportUsersService
  #call
    should return all users
    should save valid users

PasswordValidator
  valid password
    with atleast 1 uppercase, 1 lowercase and a digit
      is expected to be valid
    with 1 upcase, 1 downcase, a digit and a nonsequential 3 repeating characters
      is expected to be valid
  invalid password
    with error message
      shows error message
    when all are lowercase chars
      is expected to be invalid
    when all are uppercase chars
      is expected to be invalid
    when all are digits
      is expected to be invalid
    with no lowercase char
      is expected to be invalid
    with no uppercase char
      is expected to be invalid
    with no digit
      is expected to be invalid
    with sequential 3 repeating characters
      is expected to be invalid
    with sequential 3 repeating space characters
      is expected to be invalid

```
