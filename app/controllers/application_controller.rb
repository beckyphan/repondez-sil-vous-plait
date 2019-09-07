require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "r-s-v-p"
    register Sinatra::Flash
  end

  get "/" do
    erb :welcome
  end

  helpers do
    def current_user
      @current_user ||=User.find_by(id: session[:user_id])
    end

    def logged_in?
      current_user
    end

    def first_guest
      @first_guest ||=current_user.guests.first
    end

    def selected_meal(meal_name)
      if first_guest.meal.menu_item == meal_name
        "checked"
      else
        "unchecked"
      end
    end

    def session_slug
      current_user.slug
    end

    def protected_page
      if logged_in?
      else
        flash[:message] = "You must be logged in to access that page."
        redirect '/'
      end
    end

    def attending?
      current_user.rsvp == "Yes" ? "Yes" : "No"
    end

    def authorized_to_edit?(guest)
      current_user == guest.user
    end
  end

end
