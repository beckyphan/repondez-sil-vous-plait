class GuestsController < ApplicationController

  get '/guests' do
    protected_page
    erb :'index'
  end

  get '/guests/edit' do
    protected_page
    erb :'guests/edit'
  end

  get '/:slug/guests' do
    erb :'guests/show'
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
