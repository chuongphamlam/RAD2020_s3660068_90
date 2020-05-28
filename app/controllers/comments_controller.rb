class CommentsController < ApplicationController
    skip_before_action :verify_authenticity_token
    def index
        @comments = current_user.comments
        @other = Comment.where(post_id: [current_user.posts.ids]).where.not( user_id: current_user.id)
        @posts = current_user.posts
    end


  

    def create
        if  logged_in?
            comment = current_user.comments.create(comment_params)
            comment.save
            redirect_to controller: 'static_pages', action: 'show', id: comment_params["post_id"]
        else
            flash[:danger] = "Please log in."
            redirect_to login_url        
        end
    end

    private

    def comment_params
            params.require(:comment).permit(
              :post_id,
              :content,
            )
    end

end
