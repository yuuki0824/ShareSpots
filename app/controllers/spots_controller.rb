class SpotsController < ApplicationController
  before_action :user_signed_in?, only: [:create, :update, :new]
  
  def index
    @title = "Spots"
    @spots = Spot.all.order(created_at: :desc)
  end
  
  def new
    @title = "New Spot"
    @spot = Spot.new
  end
  
  def create
    @spot = current_user.spots.build(spot_params)
    if @spot.save
      flash[:success] = "Spot created"
      redirect_to user_path(current_user)
    else
      @spots = Spot.all.order(created_at: :desc)
      flash[:danger] = "spot not add."
      render 'static_pages/home'
    end
  end
  
  def show
    @spot = Spot.find(params[:id])
    @user = @spot.user
    @hash = Gmaps4rails.build_markers(@spot) do |spot, marker|
      marker.lat spot.latitude
      marker.lng spot.longitude
      marker.infowindow spot.name
      marker.json(name: spot.name)
    end
  end
    
  def like_users
    @spot = Spot.find(params[:id])
    @users = @spot.like_users
  end
  
  def edit
    @spot = Spot.find(params[:id])
  end
  
  def update
    @spot = Spot.find(params[:id])
    if @spot.update(spot_params)
      flash[:success] = "update spot"
      redirect_to @spot
    else
      render 'edit'
    end
  end
    
  
  def destroy
    @spot = current_user.spots.find_by(id: params[:id])
    return redirect_to root_url if @spot.nil?
    @spot.destroy
    flash[:success] = "Spot deleted"
    redirect_to user_path(current_user.id)
  end
  
  private
  
    def spot_params
      params.require(:spot).permit(:name, :date, :address, :description, :image)
    end
      
end
