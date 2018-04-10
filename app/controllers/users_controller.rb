class UsersController < ApplicationController
  before_action :store_return_to
  def show
    id = params[:id]
    @user = User.find(id)
  end
end
