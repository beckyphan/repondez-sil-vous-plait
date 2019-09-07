class UsersController < ApplicationController

  get '/signup' do
    erb :'users/new'
  end

  get '/login' do
    erb :'users/login'
  end

  post '/login' do
    binding.pry
    @user = User.create(params[:user])

    redirect "/#{@user.username.slug}"
  end

end
