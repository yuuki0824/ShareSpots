class SpotsController < ApplicationController
  before_action :user_signed_in?, only: [:create]
  
  def create
    @spot = current_user.spots.build(spot_params)
    if @spot.save
      flash[:success] = "Spot created"
      redirect_to user_path(current_user)
    else
      render 'static_pages/home'
    end
  end
  
  def show
    @spot = Spot.find(params[:id])
    @hash = Gmaps4rails.build_markers(@spot) do |spot, marker|
      marker.lat spot.latitude
      marker.lng spot.longitude
      marker.infowindow spot.name
      marker.json(name: spot.name)
    end
  end
  
  private
  
    def spot_params
      params.require(:spot).permit(:name, :date, :address, :description)
    end
      
end
