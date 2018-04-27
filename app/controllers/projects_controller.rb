class ProjectsController < ApplicationController
  before_action :store_return_to
  skip_before_action :verify_authenticity_token

  def index
     @projects = if params[:tag]
      Project.tagged_with(params[:tag])
    else
      Project.all
    end
  end

  def new
    if current_user 
     @project = Project.new
    else
      flash[:notice] = "You must be signed in to create a new project."
      redirect_to projects_path
    end
  end
  
  def request_collab
    @project = Project.find(params[:id])
    @project.add_potential=(current_user.id)
    redirect_to project_path(@project)
  end
  
  def approve
    @project = Project.find(params[:id])
    user = User.find(params[:user])
    @project.approve(params[:user])
    @project.chatroom.chatroom_users.where(user_id: user.id).first_or_create
    flash[:notice] = "#{user.name} is now a collaborator."
    redirect_to edit_project_path(@project)
  end
  
  def reject
    @project = Project.find(params[:id])
    user = User.find(params[:user]).name
    Projectuser.where(project_id: params[:id]).find_by(user_id: params[:user]).destroy
    if User.find(params[:user]).name == current_user.name
      flash[:notice] = "You are no longer requesting to collab"
      redirect_to project_path(@project)
    else  
      flash[:notice] = "#{user} has been rejected."
      redirect_to edit_project_path(@project)
    end
  end
  
  def delete_collaborator
    @project = Project.find(params[:id])
    user = User.find(params[:user])
    @project.chatroom.chatroom_users.where(user_id: user.id).destroy_all
    Projectuser.where(project_id: params[:id]).find_by(user_id: params[:user]).destroy
    if user.id == current_user.id
      flash[:notice] = "You are no longer a collaborator on #{@project.name}."
      redirect_to project_path(@project)
    else  
      flash[:notice] = "#{user.name} is no longer a collaborator."
      redirect_to edit_project_path(@project)
    end
  end

  def show
    id = params[:id]
    @project = Project.find(id)
  end
  
  def create
    @project = Project.new(project_params)
    if @project.save
      @project.add_creator=(current_user.id)
      @project.tag_list=(project_params[:tag_list])
      flash[:notice] = "#{@project.title} was successfully created."
      @chatroom = Chatroom.new
      @chatroom.project = @project # making connection between project and chatroom
      @chatroom.name = @project.title
  
      respond_to do |format|
        if @chatroom.save
          @chatroom.chatroom_users.where(user_id: current_user.id).first_or_create
          format.html { redirect_to projects_path}
          format.json { render :show, status: :created, location: @chatroom }
        else
          format.html { render :new }
          format.json { render json: @chatroom.errors, status: :unprocessable_entity }
        end
      end
    else
      render :new
    end
  end
  
  def edit
    project = Project.find(params[:id])
    if current_user == project.creator
      @project = project
    else 
      flash[:notice] = "You are not authorized to edit this project."
      redirect_to project_path(project)
    end
  end
  
  def update 
    @project = Project.find(params[:id])
    if @project.update_attributes(project_params)
      flash[:notice] = "#{@project.title} was successfully updated."
      redirect_to project_path(@project)
    else
      render :edit
    end
  end
  
  def destroy
    # @projectusers = Projectuser.find(params[:id])
    Projectuser.where(project_id: params[:id]).each do |p|
      p.destroy
    end
    Tagging.where(project_id: params[:id]).each do |t|
      t.destroy
    end
    @project = Project.find(params[:id])
    @project.destroy
    flash[:notice] = "#{@project.title} was deleted."
    redirect_to user_path(current_user)
  end
  
  private
  def project_params
    params.require(:project).permit(:title, :summary, :description, :project_type, :tag_list)
  end
end
