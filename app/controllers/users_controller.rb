class UsersController < ApplicationController

  get '/signup' do
    erb :'users/new'
  end

  get '/login' do
    erb :'users/login'
  end

  post '/login' do
    @user = User.create(params[:user])

    if @user
      session[:user_id] = @user.id
      flash[:message] = "Welcome, #{@user.first_name}!"
      redirect "/users/#{@user.username.slug}"
    else
      flash[:message] = "Unsuccessful Login. Please Sign-Up or Log-In."
      redirect "/"
    end
  end

  get '/users/:slug' do
    @user = current_user

    erb :'users/show'
  end

end
