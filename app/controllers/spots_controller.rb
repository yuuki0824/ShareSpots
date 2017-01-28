require 'pp'
class SpotsController < ApplicationController
  before_action :user_signed_in?, only: [:create, :update, :new]
  
  def index
    @title = "Spots"
    @spots = Spot.all.order(created_at: :desc).page(params[:page]).per(10)
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
    @spot.date = @spot.date.split[0]
    @user = @spot.user
    @comments = @spot.comments.all
    @comment = @spot.comments.build
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
  
  def image_create
    @spot = current_user.spots.build(spot_params)
    image_data = Magick::Image.read(@spot.image.file.file)[0]
    if image_data.get_exif_by_entry('DateTime')[0][1] != nil
      @spot.date = image_data.get_exif_by_entry('DateTime')[0][1].split(',')[0].gsub(/:/,'/')
      #写真から緯度経度の中輸出
      exif_lat = image_data.get_exif_by_entry('GPSLatitude')[0][1].to_s.split(',').map(&:strip)
      exif_lng = image_data.get_exif_by_entry('GPSLongitude')[0][1].to_s.split(',').map(&:strip)
      @spot.latitude = exif_lat.present? ? (Rational(exif_lat[0]) + Rational(exif_lat[1])/60 + Rational(exif_lat[2])/3600).to_f : nil
      @spot.longitude = exif_lng.present? ? (Rational(exif_lng[0]) + Rational(exif_lng[1])/60 + Rational(exif_lng[2])/3600).to_f : nil
  
      if @spot.save
        flash[:success] = "spot created!"
        redirect_to user_path(current_user)
      else
        @spots = Spot.all.order(created_at: :desc)
        render 'static_pages/home'
      end
    else
      flash[:danger] = "not add spot / image not data"
      render 'new'
    end
      
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
      params.require(:spot).permit(:name, :date, :address, :description, :image, :image_cache)
    end
    
end
