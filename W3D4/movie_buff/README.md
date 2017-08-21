# Movie Buff

Estimated Time: 4 hrs.

For this project you will be writing ActiveRecord queries against the the actors,
movies, and castings tables from the SQL Zoo project. We've written rspec tests
to check that you both return the correct results and query the database the
correct number of times. Please run them to check your work.

It may be helpful to refer to the [SQL Zoo solutions][sql-zoo-solutions] for guidance as
you work through these problems. Also make sure to reference the [readings from last
night][active-record-readings] as well as the [ActiveRecord docs][active-record-docs].

## Learning Goals

* Be able to write complicated ActiveRecord queries
  * Become familiar with more of ActiveRecord's functionalities
* Know how to test and debug ActiveRecord queries

## Setup

First make sure Postgres is running.

Then download the [skeleton](./skeleton.zip?raw=true). Run `bundle install`
and `./setup` to populate the database.

If you'd like to run specs for a particular problem,
simply append the corresponding line number to the spec file you want to run.

```
bundle exec rspec spec/01_queries_spec.rb:66
```

You'll be working in the `skeleton/movie_buff/` folder. Do the problems in `01_queries.rb`
before moving on to `02_queries.rb` and then `03_queries.rb`. Information on the tables you
will be working with can be found below:

```
# == Schema Information
#
# Table name: actors
#
#  id          :integer      not null, primary key
#  name        :string
#
# Table name: movies
#
#  id          :integer      not null, primary key
#  title       :string
#  yr          :integer
#  score       :float
#  votes       :integer
#  director_id :integer
#
# Table name: castings
#
#  id          :integer      not null, primary key
#  movie_id    :integer      not null
#  actor_id    :integer      not null
#  ord         :integer

```

## Notes on building ActiveRecord Queries

You can manually test queries in the `rails console`. By chaining `to_sql` on
the end of a query you can inspect the SQL query ActiveRecord makes under the
hood. This is particularly useful for debugging. ActiveRecord also has a method
`as_json` that provides the jsonified output of a query.

Also, remember that ActiveRecord can join associations defined on the model. We've gone ahead and
defined associations for actors, castings, and movies for you. Please take a look
at these associations before you begin.

Have fun and good luck!

[sql-zoo-solutions]: https://github.com/appacademy/curriculum/tree/master/sql/projects/sqlzoo/solution
[active-record-readings]: https://github.com/appacademy/curriculum/tree/master/sql#readings-65-min
[active-record-docs]: http://guides.rubyonrails.org/active_record_querying.html
