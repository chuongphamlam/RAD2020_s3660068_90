class PasswordResetsController < ApplicationController
    skip_before_action :verify_authenticity_token


    def create
        @user = User.where(email: user_params["email"]).first
        if @user.blank?
          flash[:danger] = "Wrong!! User has not been registered "
          redirect_to login_url
        else
          @user.send_password_reset
          flash[:success] = "Please check your email to comfirm change password !"
          redirect_to '/'
        end
      rescue ActiveRecord::RecordNotFound
        flash[:danger] = "Wrong!! User has not been registered "
      redirect_to login_url

    end
    
    def edit
        @user = User.find_by_password_reset_token!(params[:id])
        log_in @user
        redirect_to "/"
    end


    private
  
    def user_params
      params.require(:user).permit(:name,:mobile,:photo,:city,:intro, :email, :password, :password_confirmation)
    end
    
end
