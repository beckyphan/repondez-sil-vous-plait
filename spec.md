# Specifications for the Sinatra Assessment

Specs:
- [x] Use Sinatra to build the app
  - Used Corneal to generate Sinatra App Basics
  - Uses Sinatra (gemfile)
- [x] Use ActiveRecord for storing information in a database
  - Uses ActiveRecord and Sinatra-ActiveRecord (gemfile) to create databases
- [x] Include more than one model class (e.g. User, Post, Category)
  - Has User model
  - Has Guests model
  - Has Meal model
- [x] Include at least one has_many relationship on your User model (e.g. User has_many Posts)
  - User has_many guests
  - Guest has_one meal
- [x] Include at least one belongs_to relationship on another model (e.g. Post belongs_to User)
  - Guest belongs_to User
- [x] Include user accounts with unique login attribute (username or email)
  - User Model includes validation (Validates :username, uniqueness: true, on: :create)
- [x] Ensure that the belongs_to resource has routes for Creating, Reading, Updating and Destroying
  - a User's guests can be created, viewed, updated, and destroyed
- [x] Ensure that users can't modify content created by other users
  - Users can see all guests on the index page, but only have access to edit guests they had created
  - Users can only access specific pages and cannot type in other users' URLs to access any pages, as they will be redirected.
- [x] Include user input validations
  - A user signing up may not leave fields blank - User model validates for presence (validates :first_name, :last_name, :username, :email, :password, presence: true, on: :create)
- [x] BONUS - not required - Display validation failures to user with error message (example form URL e.g. /posts/new)
  - Use of Sinatra Flash to display messages on error messages, as well as successful saves/updates/etc.
- [x] Your README.md includes a short description, install instructions, a contributors guide and a link to the license for your code
  - Added readme to the project

Confirm
- [x] You have a large number of small Git commits
- [x] Your commit messages are meaningful
- [x] You made the changes in a commit that relate to the commit message
- [x] You don't include changes in a commit that aren't related to the commit message
