class StaticPagesController < ApplicationController
  def home
    if user_signed_in?
      @spot = current_user.spots.build
    end
  end
  
  def about
  end
end
