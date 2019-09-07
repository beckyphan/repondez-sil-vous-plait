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

  patch '/users' do
    binding.pry
    if rsvp_value == "checked"
      redirect "/guests/meals"
    else
      flash[:message] = "You have RSVP'ed No."
      redirect "/users/guests/edit"
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

  get '/users/:slug/edit' do
    protected_page

    @user = current_user

    erb :'users/edit'
  end

  get '/users/:slug' do
    protected_page

    erb :'users/show'
  end

  get '/logout' do
    session.clear

    flash[:message] = "You are now logged out."
    redirect '/'
  end

end
