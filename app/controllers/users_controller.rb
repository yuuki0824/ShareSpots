class UsersController < ApplicationController
  before_action :authenticate_user!, only:[:index, :show]
  
  def index
    @users = User.all
  end
  
  def show
    @user = User.find(params[:id])
    @spots = @user.spots.order(created_at: :desc)
  end
  
end
