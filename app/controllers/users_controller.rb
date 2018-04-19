class UsersController < ApplicationController
  before_action :store_return_to
  
  def edit
    @user = User.find(params[:id])
  end
  
  def show
    id = params[:id]
    @user = User.find(id)
  end
  
  def update 
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:notice] = "#{@user.name} was successfully updated."
      redirect_to user_path(@user)
    else
      render :edit
    end
  end
  
  def destroy
    user = User.find(params[:id]).name
    Projectuser.where(user_id: params[:id]).each do |p|
      p.destroy
    end
    User.where(id: params[:id]).each do |t|
      t.destroy
    end
    flash[:notice] = "#{user} was deleted."
    redirect_to '/'
  end 
  
  private
  def user_params
    params.require(:user).permit(:interests, :skills, :bio)
  end
end
