class UsersController < ApplicationController
  before_action :authenticate_user!, only:[:index, :show]
  before_action :set_user, only:[:show]
  
  def index
    @users = User.all
  end
  
  def show
    @profile = Profile.find_or_initialize_by(user_id: @user.id)
    @spots = @user.spots.order(created_at: :desc)
  end
  
  private
  
    def set_user
      @user = User.find(params[:id])
    end
end
