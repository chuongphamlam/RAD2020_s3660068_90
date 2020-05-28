class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception
    before_action :load_forums
    include SessionsHelper

    

    def load_forums
    if Post.count < 1 || Post.select(:forum_id).distinct.count < 2
      @forum_new = Forum.order(created_at: :desc).limit(2)
    else
      @forum_new = Forum.find(Post.group(:forum_id).count.sort[0][0], Post.group(:forum_id).count.sort[1][0])
    end
    
    end

    def logged_in_user
        unless logged_in?
          store_location
          flash[:danger] = "Please log in."
          redirect_to login_url
        end
      end

      def correct_user
        @user = User.find(session[:user_id])
        redirect_to(root_url) unless current_user?(@user)
      end
    
      def admin_user
        redirect_to(root_url) unless current_user.admin?
      end
      
end
