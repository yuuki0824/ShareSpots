class LikesController < ApplicationController
  
  def like
    @spot = Spot.find(params[:spot_id])
    current_user.likes.find_or_create_by(spot_id: @spot.id)
    render 'like'
  end
  
  def unlike
    @spot = Spot.find(params[:spot_id])
    like = current_user.likes.find_by(spot_id: @spot.id)
    like.destroy
    render 'unlike'
  end
end
