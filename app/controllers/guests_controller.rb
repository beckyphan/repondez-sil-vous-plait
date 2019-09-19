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
      flash[:message] = "You are not allotted another guest."
      redirect '/guests/edit'
    end
  end

  get '/guests/edit' do
    protected_page
    @plus_ones = current_user.guests[1..-1]
    erb :'/guests/edit'
  end

  get '/users/:slug/guests' do
    protected_page
    erb :'guests/show'
  end

  patch '/users/:slug/guests' do

    params[:guest].each do |guest|

      @guest = Guest.find_by(id: guest[0])

      if @guest.user == current_user
        @guest.update(guest[1][:attributes])
        @guest.meal.update(guest[1][:meal])
      else
        flash[:message] = "You are not allowed to edit that guest."
        redirect '/guests/edit'
      end
    end

    flash[:message] = "Your guest(s) has been updated!"
    redirect "/users/#{session_slug}/guests"
  end

  post '/users/:slug/guests' do
    if current_user.guests.count < current_user.guest_limit
      plus_one = Guest.create(params[:guest])
      current_user.guests << plus_one
      plus_one.meal = Meal.create(params[:meal])

      flash[:message] = "Your guest has been added!"
      redirect "users/#{session_slug}/guests"
    else
      flash[:message] = "You are not alloted another guest."
      redirect '/guests/edit'
    end
  end

  get '/users/:slug/guests/:id' do
    protected_page

    if Guest.find_by(id: params[:id])
      @delete_guest = Guest.find_by(id: params[:id])
      erb :'guests/delete'
    else
      redirect '/guests/edit'
    end
  end


  delete '/users/:slug/guests' do
    @guest = Guest.find_by(id: params[:guest_id])
    if @guest.user == current_user
      @guest.destroy
      flash[:message] = "Your guest has been deleted!"
      redirect "users/#{session_slug}/guests"
    else
      flash[:message] = "You are not allowed to delete that guest."
      redirect '/guests/edit'
    end
  end

  delete '/guests' do
    @user = current_user
    @user.update(rsvp: "No")

    # added 'dependent: :destroy' to guest model to destroy its associated meal if guest destroyed
    # @user.guests.each do |guest|
    #   if guest.meal != nil
    #     guest.meal.destroy
    #   end
    # end

    @user.guests.destroy_all

    flash[:message] = "You have RSVP'ed No & have been removed from Guest List"

    redirect '/guests'
  end

end
