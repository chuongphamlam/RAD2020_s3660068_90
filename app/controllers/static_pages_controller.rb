class StaticPagesController < ApplicationController
  before_action :logged_in_user, only: [:edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update]
  before_action :load_resource
  before_action :load_forums
  skip_before_action :verify_authenticity_token
  include StaticPagesHelper


  def index
    if params[:search].nil? && params[:select].nil? 
      @posts = Post.all
    else
      if params[:select].nil?
      @posts = Post.where("lower(title) like ?", "%#{params['search'].downcase}%").or(Post.where("lower(content) like ?", "%#{params['search'].downcase}%"))
      flash[:success] = "There are #{@posts.count < 0 ? @posts.count : "no" } matching records !!"
      else
        ids = params[:select].split(',')
        (ids.find_all { |e| ids.count(e) > 1 }).each {|item| ids.delete(item)}
        @posts =  params[:select] == "all" ? Post.all : Post.where(forum_id:  ids)  
      end
    end
  end


  def show
    counter(@post)
    flash[:success]
    rescue ActiveRecord::RecordNotFound
      flash[:danger] = "Wrong!! Record Not Found"
    redirect_to :action => 'index'
  end

  def new
    logged_in_user
  end

  def edit
    @forums = Forum.all
    rescue ActiveRecord::RecordNotFound
    flash[:danger] = "Something wrong  it"
    redirect_to :action => 'index'
    logged_in_user
  end

  def create
    if @post.save
      flash[:success] = "Create Success !"
      redirect_to :action => 'index'  
    else
      flash[:danger] = "Create Errors !"
      render :action => "new"
    end
  end

  def update
    if @post.update(write_params)
      flash[:success] = "Update Success !"
      redirect_to :action => 'index'  
    else
      flash[:danger] = "Update Errors !"
      render :action => "edit"
    end
  end

  def destroy
    if current_user.id = @post.user.id
      @post.destroy
      flash[:success] = "Delete success"
      redirect_to :action => 'index'      
    else
      flash[:danger] = "Something Errors !"
      render :action => "new"
    end
   
  end

  private


  def load_resource
    case params[:action].to_sym
    when :new, :index
      @forums = Forum.all
      @posts_sort_date = Post.order(counter: :desc).limit(5)
      @users = User.order(created_at: :desc).limit(12)
    when  :destroy, :show, :edit
      @post = Post.find(params[:id])
      @comments = @post.comments
    when :update
      @post = Post.find(params[:id])
    when :create
      @post = current_user.posts.new(write_params)
    end
  end


  def search_params
    params.permit(:search,:select)
  end


  def write_params
    params.require(:post).permit(
      :title,
      :forum_id,
      :photo,
      :content,
    )
  end
end
