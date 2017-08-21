# URL Shortener: Part SQL

In this project, we'll build a tool that will take an arbitrarily-long
URL and will shorten it for the user. Subsequent users can then give the
short URL back to our tool and be redirected to the original URL. We'll
also track clickthroughs, since these can be really helpful for business
analytics.

URL-shortening apps like ours are useful for embedding long URLs in
space-constrained messages like tweets. You can play around with
[Google's shortener][goo-gl] if you'd like to get a feel for how
this works.

Unfortunately, we don't know how to build things in the browser yet, so
we'll have to be content with a simple [CLI][what-is-cli] tool, though
we can use the `launchy` gem to pop open the original URL in a browser.

Throughout this project you're going to be navigating through many files. Using
the file tree to navigate will take a long time. Make sure to instead press ⌘+T
and then type the file name to quickly find the files you are looking for.

[goo-gl]: https://goo.gl
[what-is-cli]: http://www.techopedia.com/definition/3337/command-line-interface-cli

## Learning Goals

* Be able to create a new Rails project
* Be able to navigate a Rails project using the keyboard
* Be able to change the database using migrations
* Be able to write both database constraints and model-level validations
* Be able to write associations
* Understand the purpose of adding an index to columns in our database

## Phase 0: Setup

Go ahead and create a new Rails project...

```
$ rails new URLShortener --database postgresql
```
Create the database with the following command...

```
$ bundle exec rails db:create
```

You now have a working Rails app with database! We can now run migrations to
add tables to our database.

## Phase I: Users

### Overview

In this initial phase of the project we are going to create a Users table and
model in our app. We want our users to each have an email associated with their
account and we want to make sure that when we create a new user, they always
supply an email. We also want to ensure that email is unique. We don't want the
same person registering on our app with a duplicate email. That wouldn't make sense!

The naming of your files is going to be essential. When you try to create an
instance of a model, it looks in the models folder for a file that is the
`snake_case`-ified version of your model's name. Also, it will, by default,
infer that the name of the table is the pluralized, snake cased, version of your
model. For example, if I had a `GoodStudent` model, Rails would look in the
`app/models` folder for a file called `good_student.rb`. Upon finding and
loading this file, it would create an instance of the class with data from a
table it assumes to be `good_students`. **If your naming doesn't _EXACTLY_
follow convention, you're gonna have a bad time.**

### Instructions

Use the Rails scaffolding engine to create a new migration file...

```
$ bundle exec rails generate migration CreateUsers
```

This will automatically generate a migration that creates the `users`
table. This table needs only one column in addition to the ever present
`t.timestamps`, and that is `email`.

We will also [create an index][indexing-reading] for the email column in
the `users` table. This will allow us to look up rows in the table
much more quickly. In addition to improving lookup performance we
can also enforce uniqueness of one or more columns at the database
level using an index. [These docs][add-index-docs] will give you the syntax needed.

Double check that your migration file syntax is correct and then setup your database
by running your migrations with: `bundle exec rails db:migrate`.

Next, let's create a `User` model. No magic to this, just create a `user.rb`
file in your `app/models` folder.

Add uniqueness and presence [validations][validations-reading]. Without
these, people might go about creating user accounts without emails. We
cannot tolerate such misbehavior.

[indexing-reading]: ../../readings/indexing.md
[validations-reading]: ../../readings/validations.md
[add-index-docs]: http://apidock.com/rails/ActiveRecord/ConnectionAdapters/SchemaStatements/add_index

### Recap

You should now have a User table and model. Both your database and model should require
that a user has provided your app with a unique email. To test that everything is
working try to create a user without an email in the console. You shouldn't be able
to persist that user to the database! Now create a user with an email. Does it
work? It should if there are no other users in the database with that same email.

## Phase II: `ShortenedUrl`

### Overview

Now it's time to create the table and model that will handle the long URL the user
provides our app as well as the shortened urls our app will create.
When we're done we'll eventually want to be able to find urls for a particular
user. This means we'll need to define an Active Record association to manage that
relationship. We'll also want users to be able to type in the short url and get
back the long version, although our app won't have this functionality right away.

### Instructions

Create a `shortened_urls` table and write a `ShortenedUrl` model. For which columns
in `ShortenedUrl` should we add indices? Which index should be unique?
Store both the `long_url` and `short_url` as string columns. Also store the id
of the user who submitted the url.

**NB:** `ShortenedUrl` is a model, `shortened_urls` is the table it
_models_ to, and `short_url` is the string column in the
`shortened_urls` table that contains the actual shortened url string.
Confusing, I know, but this illustrates why good naming is so important.
One bad name confuses every poor dev who tries to maintain the code
after you.

Along with adding these database level constraints remember to add uniqueness
and presence validations on the model level as well.

Once you have your migration and model written how you would like, make sure to
run your migrations and test out ShortenedUrl in the Rails console.

>#### :bulb: Aside: But Why No `LongUrl` Model?
>We **could** factor out the `long_url` to its own model, `LongUrl`, and store in `ShortenedUrl` a foreign key to a `LongUrl`. If the URLs are super long this would reduce data usage by allowing multiple `ShortUrl` records to reference a single `LongUrl`, removing duplication of the long url string.
>
>On the other hand, factoring it out into its own table forces two steps of lookup to resolve a short URL:
>
>1. Find the `ShortenedUrl` record by matching `short_url`
>2. Find the associated `LongUrl` record by matching to `long_url_id` to a `LongUrl` primary key, `id`
>
>**NB: ActiveRecord will still execute a single query, but SQL will be doing a bit more work under the hood**
>
>For this reason, we can expect better _performance_ by storing the long url in the `shortened_urls` table. Ultimately, for our implementation we have chosen to prefer performance over reducing our database size.

Now it's time for us to actually shorten a URL for the users. We do this by
generating a random, easy to remember, 16 character random code and storing
this code as the `short_url` in our table. Now, we can search for this record
by the `short_url` and we get the `long_url`.

We will be generating a random string with
`SecureRandom::urlsafe_base64`. In [Base64 encoding][wiki-base64], a random number with a given byte-length is generated and returned as a string.

Write a method, `ShortenedUrl::random_code` that uses
`SecureRandom::urlsafe_base64` to generate a random 16-byte string (**NOTE: 16-bytes != 16 characters**).
Handle the vanishingly small possibility that a code has already been
taken: keep generating codes until we find one that isn't the same as one
already stored as the `short_url` of any record in our table. Return the
first unused random code. You may wish to use the ActiveRecord `exists?` method;
look it up :-)

[wiki-base64]: http://en.wikipedia.org/wiki/Base64

Write a factory method that takes a `User` object and a `long_url`
string and `create!`s a new `ShortenedUrl`.

Write `submitter` and `submitted_urls` associations to `ShortenedUrl`
and `User`.

### Recap

At this point you should have a `shortened_urls` table and a `ShortenedUrl`
model. The factory method you wrote that creates a shortened url and persists
it to the database should use the `ShortenedUrl::random_code` method to provide
a unique `short_url`. Make sure that each `ShortenedUrl` has a unique 16
letter `short_url` code.

Go ahead and use the Rails console to create some more `User`s and some
`ShortenedUrl`s. Check that the associations you wrote are working. Calling
`submitter` on a shortened url should return the submitter for that url.
Calling `submitted_urls` on a user should return the urls submitted by that user.

## Phase III: Tracking `Visit`s

### Overview

In this phase of the project we want to code the functionality to track how many
times a shortened URL has been visited. We also want to be able to fetch all of
the shortened urls a user has visited.

To accomplish this, we'll need a `Visit` join table model. We'll use this join
to link user visits to certain urls. We'll also add associations connecting
`Visit`,`User`, and `ShortenedUrl`.

### Instructions

First write the `Visit` join table model. Add appropriate indices and validations.
Be sure to include timestamps on your `Visit` model. We'll need them later.

Add a convenience factory method called `Visit::record_visit!(user, shortened_url)`
that will create a `Visit` object recording a visit from a `User` to the given `ShortenedUrl`.

Now write `visitors` and `visited_urls` associations on `ShortenedUrl` and
`User`. These associations will have to traverse associations in
`Visit`. Define appropriate associations in `Visit`; what kind of
association can traverse other associations?

**Important Note**: because a `User` can visit a `ShortenedUrl` many times,
there are potentially many `Visit` records connecting the same user to the same
shortened URL. Thus, your `ShortenedUrl#visitors` association may repeat the
same user several times, and your `User#visited_urls` association may repeat the
same shortened URL several times. We'll address this soon!

Add the three following methods to the `ShortenedUrl` class:

* `#num_clicks`
* `#num_uniques`
* `#num_recent_uniques`

`ShortenedUrl#num_clicks` should count the number of clicks on a `ShortenedUrl`.

`ShortenedUrl#num_uniques` should determine the number of **distinct** users
who have clicked a link.

How do we do this in ActiveRecord? In addition to our `visits` association, we
will want to:

* Use the [select](http://api.rubyonrails.org/classes/ActiveRecord/QueryMethods.html#method-i-select) method to select just the `user_id` column
* Use the [distinct](http://api.rubyonrails.org/classes/ActiveRecord/QueryMethods.html#method-i-distinct) method to de-duplicate the `user_id`s so that each user
  counts only once.
* Use the `count` method to count the unique users.

The SQL we want looks like this:

```sql
SELECT
  COUNT(DISTINCT user_id)
FROM
  visits
WHERE
  visits.shortened_url_id = ?
```

Lastly, write `ShortenedUrl#num_recent_uniques`, which should only collect unique
clicks in a recent time period (say, `10.minutes.ago`). This involves throwing a
[where](http://api.rubyonrails.org/classes/ActiveRecord/QueryMethods.html#method-i-where) clause onto your `num_uniques` code.

You probably wrote a has_many association that looked like this:

```ruby
class ShortenedUrl < ApplicationRecord
  has_many :visitors,
    through: :visits,
    source: :visitor
end
```

To get this association to return each visitor exactly once, we can add a magic
"scope block" to ask Rails to remove duplicates:

```ruby
class ShortenedUrl < ApplicationRecord
  has_many :visitors,
    Proc.new { distinct }, #<<<
    through: :visits,
    source: :visitor
end
```

This will call `#distinct` on the visitors, returning only unique visitors. It
is common to write a lambda literal like so `-> { distinct }` rather than `Proc.new { distinct }`, because it is
a little shorter.

Use a "distinct-ified" version of `visitors` to rewrite `num_uniques` simply.
Also, write a distinct-ified version of `visited_urls`.

### Recap

Congrats! You should now have a join table and model for visits, linking users
to urls. With this join table you should have been able to do the followings things:

* Write `visitors` and `visited_urls` Active Record relations connecting users
to urls and vice-versa.
* Retrieve the recent unique visits for a particular url.

Create some entries in your `Visit` join table using `Visit::record_visit!`. After
making sure that your method is working (make sure a new entry in the `visits`
table is created with the correct information), test out your Active Record relations.
Everything should be working before you move on.

## Phase IV: A simple CLI

### Overview

Now we're going to write a very simple command-line interface in `bin/cli`.
We'll write this as a command-line script, we'll omit the `.rb` extension.
Instead, we can write `#!/usr/bin/env ruby` on the first line of the file to tell the command-line interpreter that this is a ruby file. This is known as a [Shebang][shebang].
You already know how to do this -- you have written programs that had CLIs using functions like `puts` and `gets.chomp` (e.g., Chess, Minesweeper, &c.).

[shebang]: https://en.wikipedia.org/wiki/Shebang_(Unix)

### Instructions

Your CLI should have the following features:

* Ask the user for their email; find the `User` with this email. You
  don't have to support users signing up through the CLI.
* Give the user the option of visiting a shortened URL or creating
  one.
* When they select create a new short URL, create one and show it to
  them.
* Use the `launchy` gem to open a URL in the browser; record a visit.
  (You'll need to add `launchy` to your Gemfile and run `bundle install`)

Remember not to pollute your models with UI code. You should keep all of
that in your CLI script. Suppose you want to write a web version of this
program soon. The CLI interaction logic can't be reused in the web
version, but if you embedded that in your models, this might cause some
mysterious behavior in your web app.

Run your script using the `rails runner` command. This will load the
**Rails environment** for you, so you'll be able to use your classes
without requiring them explicitly. Importantly, `rails runner` will also
connect to the DB so you can query tables.

### Recap

You should have now have, in addition to a working web app, a CLI script that
allows users to seamlessly interact with your app.

Your script should behave something like this:

```
~/repos/appacademy/URLShortener$ rails runner bin/cli

Input your email:
> ned@appacademy.io

What do you want to do?
0. Create shortened URL
1. Visit shortened URL
> 0

Type in your long url
> http://www.appacademy.io

Short url is: Pm6T7vWIhTWfMzLaT02YHQ
Goodbye!

~/repos/appacademy/URLShortener$ rails runner bin/cli

Input your email:
> ned@appacademy.io

What do you want to do?
0. Create shortened URL
1. Visit shortened URL
> 1

Type in the shortened URL
> Pm6T7vWIhTWfMzLaT02YHQ

Launching http://www.appacademy.io ...
Goodbye!

~/repos/appacademy/URLShortener$ rails c
Loading development environment (Rails 3.2.11)
1.9.3-p448 :001 > ShortenedUrl.find_by_short_url("Pm6T7vWIhTWfMzLaT02YHQ").visits
  ShortenedUrl Load (0.1ms)  SELECT "shortened_urls".* FROM "shortened_urls" WHERE "shortened_urls"."short_url" = 'Pm6T7vWIhTWfMzLaT02YHQ' LIMIT 1
  Visit Load (0.1ms)  SELECT "visits".* FROM "visits" WHERE "visits"."shortened_url_id" = 1
 => [#<Visit id: 1, user_id: 1, shortened_url_id: 1, created_at: "2013-08-18 19:15:55", updated_at: "2013-08-18 19:15:55">]
```

Test that your CLI works! You should be able to login, as well as create and visit
shortened urls.

## Phase V: TagTopic and Tagging

### Overview

In this phase we'll allow users to choose a set of predefined `TagTopic`'s
for links (news, music, sports, etc.).

### Instructions

Before starting think over with your pair what columns should be indexed. Create
these models with the appropriate nullity and uniqueness constraints and seed your
database with some `TagTopic`s and `Taggings`.

Once you have your table and model set up, define a `tag_topics` relation on
the `ShortenedUrl` model. `tag_topics` should return all of the tag topics for
a given URL. Since the relationship between `TagTopic`s and `URL`s is many-to-many, you'll
need a join model like `Tagging`s.

Now write a method `TagTopic#popular_links` that returns the 5 most visited links
for that `TagTopic` along with the number of times each link has been clicked.

Don't worry about updating your CLI so users can add a `TagTopic` to a new URL.
Just make sure that you can create working `TagTopic` objects and view the most
popular links for a tag in the console.

### Recap

At this point you should have added a table and model for tag topics, as well as
a `tag_topics` association. Test that your new associations and `TagTopic#popular_links`
method are working in the console.

## Phase VI: Custom Validations

### Overview

Now we're going to write a series of custom validations to manage how our users
submit URLs to our application. First, we're going to prevent users from submitting
more than 5 URLs in a single minute. Then we're going to monetize our app by
limiting the number of total URLs non-premium users can submit to 5.

### Instructions

First, write a custom validation method `ShortenedUrl#no_spamming`. Remember to provide
an informative error message if the validation fails.

Now add a custom validation method `ShortenedUrl#nonpremium_max`. To do this you'll
first have to add a "premium" boolean column to your `Users` table. This column should
default to false unless a boolean is given.

### Recap

You've now written two custom validations. To test our anti-spamming validation
try to create more than 5 URLs in the console for one user in under a minute.
If your method is working correctly you shouldn't be able to! Now test that non-premium
users cannot create more than 5 total URLs. Once everything is working move
on to the next step!

## Phase VII: Pruning Stale URLs

### Overview

We don't want our app to store URLs indefinitely, so in this phase we're going
to remove URLs from our database that haven't been visited for a given period of time.

### Instructions

Write a `ShortenedUrl::prune` method that deletes any shortened URLs
that have not been visited in the last (n) minutes. You will also need
to delete any shortened URLs that are older than (n) minutes and have
never been visited - make sure `ShortenedUrl::prune` only fires a single
query. Use the following code snippet in `rails console` to make sure
your `prune` method is working as hoped.

```ruby
u1 = User.create!(email: 'jefferson@cats.com', premium: true)
u2 = User.create!(email: 'muenster@cats.com')

su1 = ShortenedUrl.create_for_user_and_long_url!(u1, 'www.boxes.com')
su2 = ShortenedUrl.create_for_user_and_long_url!(u2, 'www.meowmix.com')
su3 = ShortenedUrl.create_for_user_and_long_url!(u2, 'www.smallrodents.com')

v1 = Visit.create!(user_id: u1.id, shortened_url_id: su1.id)
v2 = Visit.create!(user_id: u1.id, shortened_url_id: su2.id)

ShortenedUrl.all # should return su1, su2 and su3
ShortenedUrl.prune(10)
ShortenedUrl.all # should return su1, su2 and su3

# wait at least one minute
ShortenedUrl.prune(1)
ShortenedUrl.all # should return only su1

su2 = ShortenedUrl.create_for_user_and_long_url!(u2, 'www.meowmix.com')
v3 = Visit.create!(user_id: u2.id, shortened_url_id: su2.id)
# wait at least two minutes
v4 = Visit.create!(user_id: u1.id, shortened_url_id: su2.id)

ShortenedUrl.prune(1)
ShortenedUrl.all # should return su1 and su2
```

Once you have `ShortenedUrl::prune` working, check out ActiveRecord's
[dependent: :destroy][destroy] for associations and use it to destroy
the visits and taggings that belong to old shortened URLs. Once you
have tested that your taggings and visits are being deleted write a
[rake task][rake-tutorial] to automate this process. Finally, adjust
`ShortenedUrl::prune` so that URLs submitted by premium users are not pruned.

### Recap

You should now have an automated prune method that removes URLs submitted by
non-premium users after a given period of time. To test this create a number of
URLs as a non-premium user. Are these URLs eventually removed from the database?
They should be!

## Bonus phase 1: Alternative URL shortening strategies

Now its time to implement some alternative URL shortening strategies. First, create
custom URLs for premium users.

Next, use a series of random dictionary words to generate the short URL.

## Bonus phase 2: Voting on URLs

Let's also add the functionality to vote on URLs. To do this you'll need a vote
model. Prevent users from voting more than once per user/url combo. Also prevent
users from voting for their own URLs.

Once you have voting working, you can add the two following methods:
  * `ShortenedUrl::top`, sorted by total vote score
  * `ShortenedUrl::hot`, sorted by vote score in the last (n) minutes

[destroy]: http://guides.rubyonrails.org/association_basics.html#has-many-association-reference
[count-distinct-docs]: http://api.rubyonrails.org/classes/ActiveRecord/Calculations.html#method-i-count
[rake-tutorial]: http://tutorials.jumpstartlab.com/topics/systems/automation.html
