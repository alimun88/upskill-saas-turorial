class UsersController < ApplicationController
  before_action :authenticate_user!
  
  # GET to /user/:id
  def show
    @user = User.find( params[:id])
  end
  
  # GET to /users
  def index
    @users = User.includes(:profile)
  end
end