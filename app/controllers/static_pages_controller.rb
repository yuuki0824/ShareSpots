class StaticPagesController < ApplicationController
  
  def home
    if user_signed_in?
      @spot = current_user.spots.build
      @spots = Spot.all.order(created_at: :desc).limit(5)
    end
  end
  
  def about
  end
end
