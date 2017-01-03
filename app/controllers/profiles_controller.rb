class ProfilesController < ApplicationController
  
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
  
  private
  def profile_params
  params.require(:profile).permit(:first_name, :last_name, :avatar, :job_title, :phone_number, :contact_email, :description)
  end
end