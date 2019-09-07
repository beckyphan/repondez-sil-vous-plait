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

    def authorized_to_edit?(guest)
      current_user == guest.user
    end
  end

end
