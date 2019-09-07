M:
  User
    First Name
    Last Name
    Username
    Email Address
    Password
    RSVP
    Guest Limit
    has_many guests

  Guest
    First Name
    Last Name
    belongs_to user
    has_one meal

  Meal
    Meal Type
    Notes (ie allergies, food restrictions, etc.)
    has_many guests

V:
  Everyone
    View Full Guest List
    View Meals/Menu
      - View Stats on # of Each Meals Chosen
    Log-In/Sign-Up Page

  User
    Home Page = Dashboard
      View User's Info
      View User's Guests
    Create User's Guests' Info
    View/Read User's Guests' Info
    Edit/Update User's Guests' Info
    Delete User's Guests' Info
    Log-out Page

C:
  ApplicationController
  UsersController
  GuestsController
  MealsController
