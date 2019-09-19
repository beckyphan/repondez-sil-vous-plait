# Répondez S'il Vous Plaît

repondez-sil-vous-plait is a sinatra application that allows Users to RSVP for a wedding or other event.

Users must sign-up to access most of the site. Signing-up requires input of a First Name, Last Name, unique username, email address, and a password.

By default, users currently have a guest limit of 3, including themselves (aka User + 2 Plus One's).

A user has_many guests, and each guest has_one meal.

Meals are currently pre-set to:
- Filet Mignon with Garlic Herb Butter
- Crispy Skin Salmon
- Mushroom & Chervil Risotto
- Tofu Banh Mi Sliders

Users can log-in to view all attendees of the event, RSVP/update their RSVP, select their meal choice, add Plus One's, and select their guests' meals.

Users who RSVP 'No' will have their RSVP updated and meal choice and guests deleted. Users may also delete their account to delete all stored information.

## Installation

To use this application locally, fork and clone this repository onto your computer and run ```shotgun``` to get a local server running the application.

## Usage

This application allows guests to submit data, including name, meal choice for an event, and guests/guest info. It uses ActiveRecord validations in the User model to prevent users from having the same username, which is used to log-in after sign-up.

Users can view all attendees, but may not alter anyone on the guest list other than their own plus-one's.
Ideally, guests would not overlap by bringing the same plus-one's and plus-one's need not make an account as they are accounted for by their host/user.

database schema is as follows:
"users"
  t.string  "first_name"
  t.string  "last_name"
  t.string  "username"
  t.string  "email"
  t.string  "password_digest"
  t.string  "rsvp",            default: "Yes"
  t.integer "guest_limit",     default: 3

"guests"
  t.string  "first_name"
  t.string  "last_name"
  t.integer "user_id"

"meals"
  t.string  "menu_item"
  t.string  "notes"

In the User and Guest models, I added ```dependent: :destroy``` to its has_many guests/has_one meal so that upon destroying a user, it would destroy its guests, and upon destroying guests it would destroy the guest's meal.

FYI, to update meal types, the following forms in 'views' must be updated:
- guests/edit.erb
- users/edit.erb

## Contributing
Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.

## Acknowledgements
This project was inspired by my upcoming wedding in 2020, created with the skills learned through the [flatironschool](http://flatironschool.com/), and submitted as my Sinatra Project.

## License
[MIT](https://choosealicense.com/licenses/mit/)
