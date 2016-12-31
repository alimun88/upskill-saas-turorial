class ProfilesController < ApplicationController
  
  # GET to users/:user_id/profile/new
  def new
    # render blank user profile form
    @profile = Profile.new
  end
end