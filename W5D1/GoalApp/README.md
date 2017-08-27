# Goal App

* [Live Demo](http://aa-goals.herokuapp.com/)

# Goal Setter App

Today, we're going to create an app to help people keep track of goals
they set for themselves. We'll also add a social element where people
can view and comment on each other's goals, harnessing the power of
*social* to motivate our users toward their hopes and dreams.

## Learning Goals

 * Know how to write model and controller tests using RSpec
 * Know how to write integration tests using Capybara and RSpec
 * Know what and when to test
 * Understand how to test *behavior* rather than *implementation*
 * Learn to develop one feature at a time (the 'slices' approach)
 * Recognize how **concerns** and **polymorphic associations** can
   _dry_ up your code

## Set Up

Remember to set up your app to use RSpec and Capybara.
(See the [RSpec Setup][rspec-setup] and [Capybara][Capybara] readings.)

Make sure that none of the gems `web-console`, `binding_of_caller`, or
`better_errors` is included in the `:test` group in your Gemfile, as
they can give you false positives in your tests.

Also, pick a name for your app that is not "goal" or "goals", or
anything else that will cause a conflict with a model class name.

*You MUST use git* from the beginning with this project.  This means
`git init` right away, and commit regularly. Try to commit at least after finishing each phase.

Feel free to consult the [reading on git][git-reading].

[git-reading]: ../../../ruby/readings/git-summary.md
[git-add]:  ../../../ruby/readings/git-add.md

## Phase I: User Creation & Login

### Model and Controller Tests

Today's main focus will be integration tests, but we will write some model and controller specs as an RSpec warm up!

 1. Generate the models and controllers needed for authentication and user creation. If RSpec setup went according to plan, spec files should be generated for you automatically. Do not write out your `User` model just yet - we are going to write this app TDD style!
 2. Write model specs for `User`. Remember, model specs should test your model's validations, associations, and class scope methods (eg. `User::find_by_credentials`). Use `shoulda-matchers` to write tests for each of the validations in your user model. You won't have any associations written on your user model to begin with; go back and fill these in as you go. Refer to the reading on [RSpec Model Testing](../../readings/rspec-models.md) and last night's homework as needed.
 3. Next, write controller tests for each action in your `UsersController`. Refer to the [RSpec Controller reading](../../readings/rspec-controllers.md) and last night's homework as needed.

Run your specs and watch them fail. Now, implement `User` and `UsersController` and experience the joy of turning your specs green!

Let's skip any other model or controller specs so we can move on to new material, writing integration tests.

### Integration Tests

For the remainder of the day, we'll be writing integration tests and utilizing the joyous creature that is Capybara!

 1. Write integration tests for just this feature. (Tests should fail at
 beginning.) Write only one test at a time before implementing the
 corresponding feature logic.

  Here is an outline to get you started for the Authentication
  integration tests:

  ```ruby
  # spec/features/auth_spec.rb

  require 'spec_helper'
  require 'rails_helper'

  feature 'the signup process' do
    scenario 'has a new user page'

    feature 'signing up a user' do

      scenario 'shows username on the homepage after signup'

    end
  end

  feature 'logging in' do
    scenario 'shows username on the homepage after login'

  end

  feature 'logging out' do
    scenario 'begins with a logged out state'

    scenario 'doesn\'t show username on the homepage after logout'

  end

  ```

Start filling in the missing test logic, one test at a time.

 1. After you fill in each test, implement enough of the application
 logic to make the test pass. Then go back and write the next test.

 2. Refactor any obvious bugs or flaws which remain.

This is the 'Red, Green, Refactor' approach.

[rspec-setup]: ../../readings/rspec-and-rails-setup.md
[capybara]: ../../readings/capybara.md

## Phase II: Goals

Let's move on to the 'goals' feature. Users should be able to CRUD
(create, read, update, and delete) their goals. Goals can be private or
public - other users should not see 'private' goals, but a user should
see all of their own goals.

Implement the feature test-first: red to green!

Think of a way for the user to keep track of which goals are completed.
When writing a test for this, focus on testing the behavior rather than
the feature's implementation. In this case, that means your test should
work if the user can track their goal completion, regardless of how the
code behind that feature works.

## Phase III: Comment ALL the things!

Here we're going to see how tests can be reused, even after you throw
away the original code (Also, we're going to see how awesome polymorphic
associations and concerns are).

We need to let a user add comments. Imagine all the helpful words of
encouragement that other users could add to a goal. Ok, now here's the
crazy part. We _also_ want to be able to comment on users. This way a
user's show page will have comments and each goal will also have
comments.

### The Two-Table Approach

 We will implement the comments using two different tables,
`UserComment` and `GoalComment`.

As you implement this, write some high-level integration tests to make
sure our comments work as expected. Use the red-green-refactor approach.
Remember, one test at a time!

Your tests will need to cover comments on both users and goals at a
minimum. Also bear in mind that we're about to replace the feature code,
so it's super important to test *behavior*, not *implementation*.

Be sure to commit periodically, and when you're satisfied with the state
of the feature and all tests pass, make a final commit and move on to
the next section.

### Create a feature branch

 Now that we have working code, we want to be sure we can always get
back to it. To accomplish this, we'll leave `master` as is and create a
new branch for our experimental work. Let's call it
`"polymorphic-comments"`:

```bash
git checkout -b polymorphic-comments
```

It's good practice to keep your `master` branch stable and do all
feature work on separate **feature branches** that will get merged back
into master once they are complete and stable.

Start off by removing all of the code you just wrote for the two-table
implementation, except for the tests and migrations. You can use `git
diff <commit_hash>` with the hash of your last pre-two-table commit to
help you remember what code you changed. Commit your changes.

### Polymorphic associations and concerns!

On this branch we are going to use _polymorphic associations_ and
_concerns_. Sounds bad ass, right? Indeed.

Polymorphic associations allow us to let two different models _share_ an
association. Specifically, `User`s and `Goal`s will both refer to the
same `Comment` model.

This is nothing to be intimidated by, it only requires a few extra
lines of code and an extra column in the `comments` table.
Here's a [reading on polymorphic associations][poly-reading] you can reference.

Think through what you will need to to make all this happen. Think about
which associations you will need. Each `User` and `Goal` should have
many `comments`, and comments will need to be associated with a
commenting user and possibly also a user being commented on.

Go ahead and create this new model and migration. Remember that you'll
need to remove the old comment tables when you create the new one. See
if you can migrate the data from the old tables without losing it.

Next write the associations to link all your classes together
polymorphically. Isn't this better than that lousy two-table solution?

"Now wait one moment, there!" you say. "We've removed an unneeded table
and made our comment model more extensible, but our code still isn't
very _dry_ if we're writing identical code for both `User` comments and
`Goal` comments."

Well funny you should mention that. It just so happens that we have
these nice things called **Concerns** to factor out our association
logic and _dry out_ our code. Go ahead and take a look at the [concerns
reading][concerns-reading] and then create your own `Commentable`
concern.

When the tests go green you can pat yourself on the back for
successfully solving a problem using two different strategies. RSpec and
Capybara give us the comfort and security of knowing that although
things have changed beneath the hood, the presentation is identical
because **the tests are still green**. Isn't this a nice feeling?

Now let's merge our feature branch back into `master` so our main branch
can include our wonderfully refactored code:

```
$ git branch
  master
* polymorphic-comments
$ git checkout "master"
$ git merge "polymorphic-comments"
```

[poly-reading]: http://guides.rubyonrails.org/association_basics.html#polymorphic-associations
[concerns-reading]: http://signalvnoise.com/posts/3372-put-chubby-models-on-a-diet-with-concerns

## Bonus

 * Cheers: Users can give cheers for the goals of other users,
  and they have a set number of cheers to award.
 * Leaderboards (whose goals have the most cheers?)
 * Go back and add integration tests to previous day's project
 * Write unit tests for your models using [shoulda-matchers][shoulda-matchers]
   and [FactoryGirl][factory-girl].
 * Style your app.

[railsguides-polymorph-assoc]: http://guides.rubyonrails.org/v3.2.14/association_basics.html#polymorphic-associations
[shoulda-matchers]: https://github.com/thoughtbot/shoulda-matchers
[factory-girl]: https://github.com/thoughtbot/factory_girl/blob/master/GETTING_STARTED.md
