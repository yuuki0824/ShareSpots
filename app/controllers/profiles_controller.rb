class ProfilesController < ApplicationController
  
  def new
    @user = current_user
    @profile = @user.build_profile
  end
  
  def create
    @user = current_user
    @profile = @user.build_profile(profile_params)
    if @profile.save
      flash[:success] = "add profile"
      redirect_to @user
    else
      render 'new'
    end
  end
  

  def edit
    @user = current_user
    @profile = Profile.find_or_initialize_by(user_id: @user.id)
  end
  
  def update
    if @profile.update(profile_params)
      flash[:success] = "updated profile"
      redirect_to @user
    else
      render 'edit'
    end
  end
  
  private
    def profile_params
      params.require(:profile).permit(:age, :birthplace, :birthday, :self_introducation)
    end
end
