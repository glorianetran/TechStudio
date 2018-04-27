class UsersController < ApplicationController
  before_action :store_return_to
  
  def edit
    user = User.find(params[:id])
    if current_user == user
      @user = user
    else
      flash[:notice] = "You are not authorized to edit this profile."
      redirect_to user_path(user)
    end 
  end
  
  def show
    id = params[:id]
    @user = User.find(id)
  end
  
  def update 
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:notice] = "Your account was successfully updated!"
      redirect_to user_path(@user)
    else
      render :edit
    end
  end
  
  def destroy
    user = User.find(params[:id])
    user.created_projects.each do |project|
      Projectuser.where(project_id: project.id).each do |p|
        p.destroy
      end
      Tagging.where(project_id: project.id).each do |t|
        t.destroy
      end
      ChatroomUser.where(chatroom_id: project.chatroom.id).each do |c|
        c.destroy
      end
      Message.where(chatroom_id: project.chatroom.id).each do |m|
        m.destroy
      end
      project.chatroom.destroy
    end
    Projectuser.where(user_id: params[:id]).each do |p|
      p.destroy
    end
    ChatroomUser.where(user_id: user.id).each do |c|
      c.destroy
      end
    Message.where(user_id: user.id).each do |m|
      m.destroy
    end

    User.find(user.id).destroy
    flash[:notice] = "#{user.name} was deleted."
    redirect_to '/'
  end 
  
  private
  def user_params
    params.require(:user).permit(:interests, :skills, :bio)
  end
end
