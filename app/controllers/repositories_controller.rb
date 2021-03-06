class RepositoriesController < ApplicationController
  before_action :authorize, except: [:show, :index]
  
  def authorize
    if current_user.nil?
      redirect_to login_url, alert: "Not authorized! Please log in."
    else
      if @repository && @repository.user != current_user
        redirect_to root_path, alert: "Not authorized! Only #{@repository.user} has access to this post."
      end
    end
  end
  
  def index
    @repositories = Repository.all
  end

  def show
    @repository = Repository.find(params[:id])
 	 @repository.punch(request)

  end
 
  def new
    @repository = Repository.new
    
  end
 
  def edit
    @repository = Repository.find(params[:id])
  end
 
  def create
    @repository = Repository.new(repository_params)
    @repository.created_by = current_user
    if @repository.save
      redirect_to @repository
    else
      render 'new'
    end
  end
 
  def update
    @repository = Repository.find(params[:id])
 
    if @repository.update(repository_params)
      redirect_to @repository
    else
      render 'edit'
    end
  end
 
  def destroy
    @repository = Repository.find(params[:id])
    @repository.destroy
 
    redirect_to repositories_path
  end
 
  private
    def repository_params
      params.require(:repository).permit(:repository_name, :description, :access_count, :created_by, :creation_date)
    end
end
