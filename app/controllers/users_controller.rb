class UsersController < ApplicationController
  before_action :authenticate_user!, only:[:index, :show]
  before_action :set_user, only:[:show, :edit, :update]
  
  def index
    @users = User.all
  end
  
  def show
    @spots = @user.spots.order(created_at: :desc)
  end
  
  def edit
    @user.profile = Profile.new if @user.profile.blank?
  end
  
  def update
    if @user.update(user_params)
      flash[:success] = "updated user"
      redirect_to @user
    else
      render 'edit'
    end
  end
  
  private
  
    def set_user
      @user = User.find(params[:id])
    end
  
    def user_params
      params.require(:user).permit(profile_attributes: [:age, :birthplace, :birthday, :self_introducation])
    end
  
end
