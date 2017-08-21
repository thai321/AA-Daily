# Polls

In the spirit of enfranchisement, we're going to build a polling app
today!

## Learning Goals

* Be able to write migrations with indices and constraints
  * Know how to fix the effects of incorrect migrations
* Be able to write associations
* Know how to seed a project's database
* Be able to write custom validations in the model
* Be able to solve the N+1 query problem

Make sure to refer to the [ActiveRecord documentation][ar-docs] and this [ActiveRecord query guide][ar-guide] for help with writing your queries.

Generate a new rails project called `PollsApp`. Refer to yesterday's instructions if you need a reminder. Don't forget to include a PostgreSQL flag:  `rails new polls_app --database=postgresql`.

## Schema

You need to implement the following schema. Try drawing it out first to
visualize how the models interact with each other. Ask a TA if you have
any questions at this point. Then go ahead and create your migration.
Don't forget to add appropriate indices and constraints!

* `User`
  * Record a `username`; make sure it is unique.
* `Poll`
  * A `Poll` belongs to an author (`User`)
  * Record a `title`.
* `Question`
  * A `Poll` has many `Question`s. Record the `text`.
* `AnswerChoice`
  * A `Question` has many `AnswerChoice`s. These are the options that a `User` can choose from when responding to the question. Record the `text`.
* `Response`
  * A `User` answers to a `Question`s by choosing an `AnswerChoice`.
  * What pair of foreign keys will you need?

## Associations

Now go ahead and create your models. Write the following associations:

* `User`
  * `authored_polls`
  * `responses`
* `Poll`
  * `author`
  * `questions`
* `Question`
  * `answer_choices`
  * `poll`
* `AnswerChoice`
  * `question`
  * `responses`
* `Response`
  * `answer_choice`
  * `respondent`

## Seed The Database

At this point, it might be nice to have some data to play around with so
you can test easily. Go ahead and open up `db/seeds.rb` and use normal
Rails commands to create some seed data. Then run `bundle exec rails db:seed`.

If your column names are different, you may have to tweak the seed file
first (this would be a good excuse to utilize that ⌘D shortcut).

[thomasbcolley-seed-file]: https://gist.github.com/thomasbcolley/572c0a588f91a7410963

## Model Level Validations

Add `presence` and `uniqueness` validations wherever required.

**N.B.** Remember, Rails 5 automatically validates the presence of
belongs_to associations.

### User Can't Create Multiple Responses To The Same Question

We will write a custom validation method, `not_duplicate_response`, to
check that the `respondent` has not previously answered this question.
This is a deceptively hard thing to do and will require several steps:

#### Step 1: `Response#sibling_responses`

We'll write a method `Response#sibling_responses`. This should return
all the other Response objects for the same Question. To do this, first
add the following associations:

##### `Response#question`

This is a `has_one through:` association. `has_one through:` works
exactly like `has_many through:` (it has `through` and `source`
options). The only difference is it returns a single object (or `nil`)
instead of an Array (or empty array).

##### `Question#responses`

This is a `has_many through:` association.
You've got this :-)

##### Singling Yourself Out

Having written these associations, we should be able to write
`Response#sibling_responses` by (1) calling `#question` and then (2)
calling `#responses` on the question.

But wait... won't the current response be included in
`response.question.responses`? I'm not my own sibling, and neither
should a response be its own sibling.

The answer is yes _and_ no. Since `#responses` is issuing a query, if
the original response has not been saved to the DB, `#sibling_responses`
will not contain it. However, once it's persisted to the DB, the query
_will_ return it. **Test this out** by building a new (unsaved) record
and calling `sibling_responses` and then saving it and calling
`sibling_responses` again.

This be not good. How can we fix this?

Remember how associations are actually lazy-loading chain-able query
objects? Let's chain a `where` clause on here to filter out responses
with the same id as `self.id`.

**NB:** Don't forget that you need to use `where.not` here
because of [SQL ternary logic][sql-ternary-logic].

[sql-ternary-logic]: ../../readings/sql-ternary-logic.md

#### Step 2: `not_duplicate_response`

Next use `Response#sibling_responses` to write `Response#respondent_already_answered?`.
This is a predicate method that checks to see if any sibling
[`exists?`][exists?-docs] with the same `respondent_id`.

Now you can (finally) implement your validation. Use
`#respondent_already_answered?` to write a [custom
validation][custom-validation] method that will ensure that the
respondent has not already answered it.

[exists?-docs]: http://apidock.com/rails/ActiveRecord/FinderMethods/exists%3F
[custom-validation]: ../../readings/custom-validations.md

### Author Can't Respond To Own Poll

Enforce that the creator of the poll must not answer their own
questions: don't let the creator rig the results!

The simplest way is to use associations to traverse from a `Response`
object back to the `AnswerChoice`, to the `Question`, and finally the
`Poll`. You can then verify whether the poll's author is the same as
the `respondent_id`. This may involve multiple queries, but we will
later improve this.  **Don't** spend too much time trying to refactor the
method right now.  Many students have gone down this deep, dark rabbit hole
and you'll have time to explore it later.

## Poll results

Write a method `Question#results` that returns a hash of choices and
counts like so:

```ruby
q = Question.first
q.title
# => "Who is your favorite cat?"
q.results
# => { "Earl" => 3, "Breakfast" => 3, "Maru" => 300 }
```

**First**, do this with an N+1 query. Get all the `answer_choices` for
the question, then call `responses.count` for each.

**Second**, use `includes` to pre-fetch all the responses at the same
time you fetch the `answer_choices`. **Test this** to see that it
makes two queries, and not N+1. (Due to ActiveRecord weirdness, use
`responses.length` instead of `responses.count`).

This way is not ideal; it causes all responses to be transfered to the
client even though we only want to count the number of them. This is
wasteful. **Improve your solution**. First, write out the SQL that
would return answer choice rows, augmented with a column that counts
the number of responses to that answer choice. Hints:

* Use `SELECT answer_choices.*, COUNT(...)`
* You'll need to combine data from both the `answer_choices` and
  `responses` tables.
* You'll want to keep only those `answer_choices` for the relevant
  question.
* If you want to count rows for each answer choices, you'll want a
  `GROUP BY` somehow.
* Be careful not to filter out `answer_choices` merely because there
  are no `responses` choosing it. These should have a count of zero.
* `COUNT(*)` counts the number of rows in a group; `COUNT(col_name)`
  counts the number of rows where `col_name IS NOT NULL`.

**Show your TA your SQL code**. Having done this, write the query in
ActiveRecord. Hints:

* You'll want your `self.answer_choices` association
* You'll want to use `select`, `joins`, and `group`.
* You can do a `LEFT OUTER JOIN` if you use a SQL fragment in your
  `joins`.

## Bonus: More Methods

Write a `User#completed_polls` method: it should return polls where
the user has answered all of the questions in the poll.

Again, **write the SQL first**. Start by counting the questions per
poll:

* You want data from `polls` and `questions`.
* You want the number of questions per poll, so what do you
  `GROUP BY`?
* How do you `SELECT` all polls columns plus count the number of
  questions

Next, let's extend our query to count the number of responses from
this user:

* We need `responses` data, so continue the JOINs.
* We don't want to discard a question if no one responded to it (an
  unanswered question still counts to the total # of questions).
  What kind of JOIN is appropriate?
* Joining against all the `responses` is unnecessary; we only care
  about the user's responses. JOIN with a subquery on responses.
* Why would a `WHERE responses.respondent_id = ?` not work at the top
  level; **talk it over with your TA**.
* Lastly, use a `HAVING` to eliminate those polls where the number of
  questions is not equal to the number of responses.

**Verify this SQL** with `Poll::find_by_sql` to run raw SQL returning
`Poll` objects. Ask your TA if you don't know how. Then write it in
ActiveRecord.

You can write an uncompleted polls method too; it should return polls
where the user has answered at least one question, but not all of
them. I think this merely uses a different `HAVING` clause, don't you?

## Bonus: Playing With Custom Validations

Improve `Response#does_not_respond_to_own_poll` to do one query by
doing a join across answer choice, question and poll to get the poll
the response is for `Poll.joins(...)...`. Then check the poll's
`author_id`.

`Response#sibling_responses` makes two queries: first it runs a query
to return the `Question` for the `Response`, then it performs a second
query to return the `#responses` for the `Question`. Can you get this
done in a single query? It likely involves joining `answer_choices` to
`questions`; we should select the answer_choice the response is for,
this will give us the one `questions` record we need. Next, we could
join back to `answer_choices` again and onward to `responses`.

BTW: this "improvement" is likely not worth the tears future readers
of your code will shed, but it's a good brain-twister.

## Technical Details

* Allow deletion of questions; clean up all related records with a
  [relational callback][relational-callback].

[relational-callback]: http://guides.rubyonrails.org/active_record_callbacks.html#relational-callbacks
[ar-docs]: http://api.rubyonrails.org/classes/ActiveRecord/QueryMethods.html
[ar-guide]: http://guides.rubyonrails.org/active_record_querying.html
