# Error Handling Funtime

Estimated time: 30min.

Oh noes, the clever TAs at App Academy made this "super useful" library, but it keeps throwing ugly error messages that are hard to understand. Let's revamp the library to throw more descriptive errors and prevent incorrect usage.

## Learning Goals
* Know how to `raise` and `rescue` an exception
* Be able to explain how an exception bubbles up after it is raised
* Know when to use `ensure` and `retry`
* Be able to choose an appropriate exception class

## Phase 1: Setup
Download the project [skeleton][skeleton]. You will primarily be working in `super_useful.rb` to improve errors in our library. The user's script, aptly named `user_script.rb`, will be using the functions and classes defined in `super_useful.rb`.

## Phase 2: Make `convert_to_int` more flexible

### Overview
Sometimes we want to return something from our function, even if the desired operation is not possible. This might mean handling potential errors in our own code and returning a suitable replacement, such as `nil` or `-1` (often used when trying to find the index of a particular element).

### Instructions
We want our dear user to be able to call `convert_to_int` with no error being raised on invalid input. Update `convert_to_int` to `rescue` any errors and return `nil` if our argument cannot be converted.

If we are handling the error thrown by `Integer(arg)`, which [`StandardError` subclass][exception-types] should we be catching? Next, update `convert_to_int` again to only rescue the correct exception type. 

**NB:** `rescue` only *rescues* `StandardError` and its subclasses. Any other `Exception` subclass is a system error and implies that something rather serious has gone wrong and our code should stop executing.

### Recap
Many times we will want to 'protect' the user from potential errors our code might throw. In this case we are protecting our user from *only* from errors we expect. It is always wise to raise and rescue more specific errors as the errors they raise are more descriptive (helpful with debugging) and it prevents the catching of errors that should 'escape' up to the calling function (catching `Exception` will even ignore system errors).

## Phase 3: Make friendly monster (maybe) let you try again

### Overview
Sometimes when an error is thrown we would like to try the failing operation again (hopefully with different input :wink:). This is often the case with user input and text parsing. Let's try to make friendly monster happy by allowing us to retry feeding it a fruit when certain errors are thrown.

### Instructions
Friendly monster is *really* friendly and *really* likes coffee, so he'd like to give us another try, but only when we give him `"coffee"`.

First, handle the errors being thrown by `#reaction` in `#feed_me_a_fruit`.

Note that `#reaction` throws errors receiving an argument that is not in `FRUITS`. Next, let's differentiate the errors thrown so our calling function, `#feed_me_a_fruit` can try to feed friendly monster again, but only when they've given it coffee.

Now that we have different error types being thrown by `#reaction` we can do a little conditional logic in `#feed_me_a_fruit` to `retry` the failing block of code again, but only if it is a coffee-related error.

### Recap
Being able to rescue and retry failing code gives us even more control over the flow of our program. Handling different errors separately gives us even more control.

## Phase 4: Ensure `BestFriend` is a real best friend

### Overview
Another use case for raising errors is to enforce correct usage of code. For example, if a function requires its arguments to be of certain types in order to execute properly, it might be best to check their type before executing any logic. This is useful because it allows us to inform the user that they are not using our function properly, rather than a runtime error being raised which may seem like a bug in our code or be more difficult to debug.

### Instructions
If we look at `user_script.rb`, we see that our dear user thinks you can be besties if you've known each other less than a year. We do not agree. Friendships, like a fine wine, need as least five years to mature. Update `BestFriend#initialize`, in `super_useful.rb`, to raise an descriptive error when `yrs_known` is less than `5`.

Test your code, then assume the role of our dear user and update our call to `BestFriend#new` to create a *real* friendship (`yrs_known>= 5`).

Our dear user also thinks it's okay to leave `name` and `fav_pastime` empty when creating a new instance of `BestFriend`. But it's not okay. It leaves `#do_friendstuff` and `#give_friendship_bracelet` sorely lacking. Poorly formatted text just makes us seethe with displeasure. Update the `initialize` method to raise descriptive errors when given strings of `length <= 0`.

Test your code, then again assume the role of our dear user and update our call to `BestFriend#new`.

### Recap
Raising errors for invalid arguments can ensure that our code is used the way we want intend. However, be aware that the types of inputs we can receive are numerous. We don't want or need to be checking against every possible type for each argument we receive.

## Resources

* [Exceptions/Error Handling reading][error-reading] from last night
* [Skorks on exceptions][skorks-exceptions]
* [Ruby Patterns][Ruby-Patterns]

[skeleton]:./skeleton.zip
[exception-types]:https://ruby-doc.org/core-2.2.0/Exception.html
[error-reading]:../../readings/errors.md
[skorks-exceptions]:http://www.skorks.com/2009/09/ruby-exceptions-and-exception-handling/
[Ruby-Patterns]:https://github.com/adomokos/DesignPatterns-Ruby/
