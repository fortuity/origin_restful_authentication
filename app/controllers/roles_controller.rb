class RolesController < ApplicationController
  layout 'application'
  
  before_filter :check_administrator_role
  before_filter :find_user, :only => [:index, :update, :destroy]

  def index
    @all_roles = Role.find(:all)
  end

  def update
    @role = Role.find(params[:id])
    unless @user.has_role?(@role.name)
      @user.roles << @role
    end
    redirect_to user_roles_path(@user)
  end

  def destroy
    @role = Role.find(params[:id])
    if @user.has_role?(@role.name)
      @user.roles.delete(@role)
    end
    if @user == current_user
      redirect_to user_path(@user)
    else
      redirect_to user_roles_path(@user)
    end
  end

protected

  def find_user
    @user = User.find(params[:user_id])
  end

end

