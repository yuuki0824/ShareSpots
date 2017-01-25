class UsersController < ApplicationController
  before_action :authenticate_user!, only:[:index, :show]
  before_action :set_user, only:[:show, :followings, :followers, :like_spots]
  
  def index
    @users = User.all
  end
  
  def show
    @profile = Profile.find_or_initialize_by(user_id: @user.id)
    @spots = @user.spots.order(created_at: :desc).page(params[:page]).per(5)
  end
  
  def followings
    @title = "follow"
    @users = @user.following_users
    render 'show_follow'
  end
  
  def followers
    @title = "follower"
    @users = @user.follower_users
    render 'show_follow'
  end
  
  def like_spots
    @title = "Like Spots"
    @spots = @user.like_spots
    render "spots/index"
  end
  
  private
  
    def set_user
      @user = User.find(params[:id])
    end
end
