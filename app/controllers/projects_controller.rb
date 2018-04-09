class ProjectsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
     @projects = if params[:tag]
      Project.tagged_with(params[:tag])
    else
      Project.all
    end
  end

  def new
     @project = Project.new
  end

  def show
    id = params[:id]
    @project = Project.find(id)
  end
  
  def create
    @project = Project.new(project_params)
    if @project.save
      @project.add_creator=(current_user.id)
      @project.tag_list=(project_params[:skills_desired])
      flash[:notice] = "#{@project.title} was successfully created."
      redirect_to projects_path
    else
      render :new
    end
  end
  
  def edit
    @project = Project.find(params[:id])
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
    redirect_to projects_path
  end
  
  private
  def project_params
    params.require(:project).permit(:title, :summary, :description, :project_type, :tag_list)
  end
end
