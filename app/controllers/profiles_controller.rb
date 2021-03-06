class ProfilesController < ApplicationController
  before_action :authenticate_user!
  before_action :only_current_user
  # GET to users/:user_id/profile/new
  def new
    # render blank user profile form
    @profile = Profile.new
  end
  
  # POST action to users/:user_id/profile
  def create
    # Ensure that we have the user filling out the form
    @user = User.find( params[:user_id])
    # Create profile specific to the user link to the form
    @profile = @user.build_profile( profile_params )
    
    if @profile.save
      flash[:success] = "Profile Updated"
      redirect_to user_path( params[:user_id])
    else
      render action: :new
    end
  end
  
   # GET to /users/:user_id/profile/edit
  def edit 
     @user = User.find( params[:user_id])
     @profile = @user.profile
  end
  
  #PUT to  /users/:user_id/profile
  def update
    @user = User.find( params[:user_id])
    @profile = @user.profile
    if @profile.update_attributes(profile_params)
      flash[:success] = "Profile Updated Successfully"
      redirect_to user_path(id: params[:user_id])
      else
      render action: :edit
    end
  end
  
  private
  def profile_params
  params.require(:profile).permit(:first_name, :last_name, :avatar, :job_title, :phone_number, :contact_email, :description)
  end
  
  def only_current_user
    @user = User.find( params[:user_id])
    redirect_to( root_url) unless @user == current_user
  end
end