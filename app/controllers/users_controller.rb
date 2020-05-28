class UsersController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update]
  before_action :admin_user, only: :destroy
  before_action :load_forums
  include UsersHelper
  
 
  def show
    @user = User.find(params[:id])  
    update_photo(@user)
  end

  def index
    @users = User.all
    render json: {
      message: 'Status: 401, Message: Unauthorized '
    }, status: :unauthorized
  end

  def new
    @user = User.new
  end


  def create
    @user = User.new(user_params)
    # Not the final implementation!
    if @user.save
      log_in @user
      flash[:success] = "Welcome to #{@user.name}"
      redirect_to "/users/#{@user.id}"
      # Handle a successful save.
    else
      render 'new'
    end

    rescue ActionController::InvalidAuthenticityToken

  end

  def edit
    @user = User.find(params[:id])
    rescue ActiveRecord::RecordNotFound
    flash[:danger] = "Something wrong  it"
    redirect_to :action => 'index'
    logged_in_user

  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to "/users/#{@user.id}"
    else
      render 'edit' 
    end
  # rescue  ActionController::InvalidAuthenticityToken

  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to users_url
  end

  private
  
    def user_params
      params.require(:user).permit(:name,:mobile,:photo,:city,:intro, :email, :password, :password_confirmation)
    end

end
