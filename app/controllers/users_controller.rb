class UsersController < ApplicationController

  get '/signup' do
    erb :'users/new'
  end

  post '/users' do
    @user = User.create(params[:user])

    if @user
      session[:user_id] = @user.id
      @user.guests << Guest.create(first_name: params[:user][:first_name], last_name: params[:user][:last_name])
      flash[:message] = "Welcome, #{current_user.first_name}!"
      redirect "/guests/edit"
    else
      flash[:message] = "Unsuccessful Sign-Up. Please Try Again."
      redirect "/"
    end
  end

  get '/login' do
    erb :'users/login'
  end

  post '/login' do
    @user = User.find_by(username: params[:user][:username])

    if @user && @user.authenticate(params[:user][:password])
      session[:user_id] = @user.id
      flash[:message] = "Welcome, #{current_user.first_name}!"
      redirect "/users/#{@user.slug}"
    else
      flash[:message] = "Unsuccessful Login. Please try again or Sign-Up."
      redirect "/"
    end
  end

  get '/:slug/edit' do
    protected_page

    @user = current_user

    erb :'users/edit'
  end

  patch '/:slug/edit' do
    @user = current_user
    @user.update(params[:user])

    if first_guest == nil
      @user.guests << Guest.create(first_name: params[:user][:first_name], last_name: params[:user][:last_name])
    end

    if attending?
      first_guest.tap do |guest|
        guest.update(first_name: params[:user][:first_name], last_name: params[:user][:last_name])

        if guest.meal == nil
          guest.meal = Meal.create(params[:meal])
        else
          guest.meal.update(params[:meal])
        end
      end

    else
      first_guest.tap do |guest|
        guest.meal = Meal.create(params[:meal])
      end
    end

    if first_guest.meal.menu_item == nil
      flash[:message] = "Please select a meal & confirm RSVP."
    else
      flash[:message] = "Your response has been saved!"
    end

    redirect "/#{session_slug}/edit"

  end

  get '/logout' do
    session.clear

    flash[:message] = "You are now logged out."
    redirect '/'
  end

end
