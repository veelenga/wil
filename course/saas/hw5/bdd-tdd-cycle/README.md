BDD, TDD Cycle
===

In this assignment you will use a combination of Behavior-Driven Design (BDD) and Test-Driven Development (TDD) with the Cucumber and RSpec tools to add a "find movies with same director" feature to RottenPotatoes, and deploy the resulting app on Heroku.

To get the initial RottenPotatoes code please clone this bdd-tdd-cycle GitHub repo as follows:

git clone https://github.com/saasbook/bdd-tdd-cycle

Please now follow the instructions below to get setup:
----

1) Change into the rottenpotatoes directory: cd bdd-tdd-cycle/rottenpotatoes  
2) Run bundle install --without production to make sure all gems are properly installed.  
3) Run bundle exec rake db:migrate to apply database migrations.  
4) Finally, run these commands to set up the Cucumber directories (under features/) and RSpec directories (under spec/) if they don't already exist, allowing overwrite of any existing files:

```shell
rails generate cucumber:install capybara
rails generate cucumber_rails_training_wheels:install
rails generate rspec:install
```
5) You can double-check if everything was installed by running the tasks `rake spec` and `rake cucumber`.  

Since presumably you have no features or specs yet, both tasks should execute correctly reporting that there are zero tests to run. Depending on your version of rspec, it may also display a message stating that it was not able to find any _spec.rb files.

**Part 1: add a Director field to Movies**

Create and apply a migration that adds the Director field to the movies table. 
The director field should be a string containing the name of the movie’s director. 
HINT: use the `add_column` method of `ActiveRecord::Migration` to do this.  

Remember that once the migration is applied, you also have to do `rake db:test:prepare` 
to load the new post-migration schema into the test database!

**Part 2: use BDD+TDD to get new scenarios passing**

We've provided [three Cucumber scenarios](http://pastebin.com/L6FYWyV7) to 
drive creation of the happy path of Search for Movies by Director.
The first lets you add director info to an existing movie, 
and doesn't require creating any new views or controller actions 
(but does require modifying existing views, and will require creating a new step definition and possibly adding a line
or two to `features/support/paths.rb`).

The second lets you click a new link on a movie details page "Find Movies With Same Director", 
and shows all movies that share the same director as the displayed movie.  
For this you'll have to modify the existing Show Movie view, and you'll have to add a route, 
view and controller method for Find With Same Director.  

The third handles the sad path, when the current movie has no director info but we try 
to do "Find with same director" anyway.

Going one Cucumber step at a time, use RSpec to create the appropriate
controller and model specs to drive the creation of the new controller
and model methods.  At the least, you will need to write tests to drive
the creation of: 

+ a RESTful route for Find Similar Movies 
(HINT: use the 'match' syntax for routes as suggested in "Non-Resource-Based Routes" 
in Section 4.1 of ESaaS) 

+ a controller method to receive the click
on "Find With Same Director", and grab the id (for example) of the movie
that is the subject of the match (i.e. the one we're trying to find
movies similar to) 

+ a model method in the Movie model to find movies
whose director matches that of the current movie 

It's up to you to
decide whether you want to handle the sad path of "no director" in the
controller method or in the model method, but you must provide a test
for whichever one you do. Remember to include the line 
`require 'spec_helper'` at the top of your *_spec.rb files.

We want you to report your code coverage as well.

Add the following lines to
the TOP of spec/spec_helper.rb and features/support/env.rb:

```ruby
require 'simplecov'
SimpleCov.start 'rails'
```

Now when you run `rake spec` or `rake cucumber`, SimpleCov will generate a report in a directory named
`coverage/`. Since both RSpec and Cucumber are so widely used, SimpleCov
can intelligently merge the results, so running the tests for Rspec does
not overwrite the coverage results from SimpleCov and vice versa. See
the [ESaaS screencast](http://vimeo.com/34754907) for step-by-step instructions on setting up SimpleCov.

**TURN-IN:**

+ Cucumber feature file (if different from the one provided) 
+ Cucumber step definitions (i.e., contents of your features/ directory)
+ RSpec tests (i.e., contents of spec/ directory) 
+ SimpleCov report files showing 90% or greater coverage for your models and controllers
+ The URI of your deployed app on Heroku that passes all the scenarios (later in the semester, 
we'll show how to run Cucumber scenarios directly against your deployed app, not just your local copy)
+ Any files you modified (i.e. app/, config/routes.rb, db/migrate/, etc.)
