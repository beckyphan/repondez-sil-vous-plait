class GuestsController < ApplicationController

  get '/guests' do
    protected_page
    erb :'guests/show'
  end

  patch '/guests' do
    binding.pry

    @user = current_user
    @user.update(params[:user])

    if attending?
      first_guest.tap do |guest|
        guest.update(params[:user])
        if guest.meal == nil
          guest.meal = Meal.create(params[:meal])
        else
          guest.meal.update(params[:meal])
        end 
      end
    else
      @user.tap do |u|
        u.update(rsvp: "Yes")
        u.guests << Guest.create(params[:user])
      end

      first_guest.tap do |guest|
        guest.meal = Meal.create(params[:meal])
      end
    end

    erb :'guests/show'

  end

  delete 'guests' do
    @user = current_user
    @user.guests.destroy_all

    redirect '/guests'
  end

end
