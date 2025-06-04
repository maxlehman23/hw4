class PlacesController < ApplicationController
  # Only allow logged-in users to access new and create
  before_action :require_login

  def index
    @places = Place.all
  end

  def show
    @place = Place.find_by({ "id" => params["id"] })
    @entries = Entry.where({ "place_id" => @place["id"] })
  end

  def new
    @place = Place.new
  end

  def create
    @place = Place.new
    @place["name"] = params["name"]

    if @place.save
      redirect_to "/places"
    else
      # optional: render new form again if save fails
      render :new
    end
  end

  private

  def require_login
    unless @current_user # or current_user if you have a helper method
      flash[:alert] = "You must be logged in to create a place."
      redirect_to login_path
    end
  end
end