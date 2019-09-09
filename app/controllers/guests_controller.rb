class GuestsController < ApplicationController

  get '/guests' do
    protected_page
    erb :'index'
  end

  get '/guests/new' do
    protected_page

    if current_user.guests.count < current_user.guest_limit
      erb :'guests/new'
    else
      flash[:message] = "You are not alloted another guest."
      redirect '/guests/edit'
    end
  end

  get '/users/:slug/guests' do
    erb :'guests/show'
  end

  post '/users/:slug/guests' do
    if current_user.guests.count < current_user.guest_limit
      plus_one = Guest.create(params[:guest])
      current_user.guests << plus_one
      plus_one.meal = Meal.create(params[:meal])

      flash[:message] = "Your guest has been added!"
      redirect "/#{session_slug}/guests"
    else
      flash[:message] = "You are not alloted another guest."
      redirect '/guests/edit'
    end
  end

  delete '/guests' do
    @user = current_user
    @user.update(rsvp: "No")

    @user.guests.each do |guest|
      if guest.meal != nil
        guest.meal.destroy
      end
    end

    @user.guests.destroy_all

    flash[:message] = "You have RSVP'ed No & have been removed from Guest List"

    redirect '/guests'
  end

end
