# Homework

**Let's create a simple Rails project and try out what we've learned so far!**

In this project we'll be creating a simple Rails project to model the relationships between people and houses. By the end of this project, each `Person` will live in a house and each `House` will have an `address`. You will be able to call `House.residents` and get a list of the `people` that live in that `House`. You will also be able to call `Person.house` and get the `House` that that `Person` lives in.

## Phase 1: `rails new`

* Create a new rails project [using PostgreSQL][rails-with-pg-reading]
  * Remember to create the database!
  * Remember that you need to have Postgres running in the background!

## Phase 2: Create Models and Migrations

* Create a `Person` model and a `people` table (each `Person` should have a `name` and a `house_id`)
  * You will need to create and run a [migration][migrations-reading] for each model.
  * You will need to create a file called `model_name.rb` in `/app/models/` for each model.
  * For each model, you should [validate][validations-reading] the presence of each of the attributes that model can have.
* Create a `House` model and a `houses` table (each `House` should have an `address`).

## Phase 3: Create associations

* [Associate][associations-reading] `Houses` with `People` such that `Houses` can have many `#residents` and each `Person` belongs to a `#house`.
  * This relies on you specifying the correct `primary_key`, `foreign_key`, and `class_name`; otherwise, when you call `House.residents`, Rails will assume you are following conventions and look for a `residents` table rather than a `people` table!

## Phase 4: Try it out!

* Use [`rails console`][orm-reading] to create some data and run some basic queries.
* You should be able to run the following:
  ```ruby
  house = House.new(address: '308 Negra Arroyo Lane')
  person = Person.new(name: 'Walter White', house_id: house.id)

  house.save!
  person.save!
  ```

N.B. Refer to the readings often.

[rails-with-pg-reading]: ../../readings/first-rails-project.md
[migrations-reading]: ../../readings/migrations.md
[validations-reading]: ../../readings/validations.md
[associations-reading]: ../../readings/belongs-to-has-many.md
[orm-reading]: ../../readings/orm.md
