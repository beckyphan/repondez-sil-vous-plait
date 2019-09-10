class UsersController < ApplicationController

  get '/signup' do
    erb :'users/new'
  end

  post '/users' do
    @user = User.create(params[:user])

    if @user
      session[:user_id] = @user.id
      @user.guests << Guest.create(first_name: params[:user][:first_name], last_name: params[:user][:last_name])
      flash[:message] = <<-FLASH
        Welcome, #{current_user.first_name}!

        Please select a meal and/or confirm your RSVP.
      FLASH

      redirect "users/#{session_slug}/edit"
    else
      flash[:message] = "Unsuccessful Sign-Up. Please Try Again."
      redirect "/"
    end
  end

  delete '/users' do
    delete_user = User.find_by(id: current_user.id)
    delete_user.guests.each do |guest|
      guest.meal.destroy
    end

    delete_user.guests.destroy_all

    delete_user.destroy

    flash[:message] = "Your account has been deleted."
    redirect '/'
  end

  get '/login' do
    erb :'users/login'
  end

  post '/login' do
    @user = User.find_by(username: params[:user][:username])

    if @user && @user.authenticate(params[:user][:password])
      session[:user_id] = @user.id
      flash[:message] = "Welcome, #{current_user.first_name}!"
      redirect "/users/#{session_slug}/guests"
    else
      flash[:message] = "Unsuccessful Login. Please try again or Sign-Up."
      redirect "/"
    end
  end

  get '/users/:slug' do
    protected_page

    erb :'users/show'
  end

  get '/users/:slug/edit' do
    protected_page

    @user = current_user

    erb :'users/edit'
  end

  patch '/users/:slug/edit' do
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
      redirect "/users/#{session_slug}/edit"
    else
      flash[:message] = "Your response has been saved!"
      redirect "/users/#{session_slug}/guests"
    end

  end

  get '/logout' do
    session.clear

    flash[:message] = "You are now logged out."
    redirect '/'
  end

end
