class UsersController < ApplicationController
  layout 'application'
  
  before_filter :not_logged_in_required, :only => [:new, :create] 
  before_filter :find_user_or_current_user, :only => [:show, :edit, :update]
  before_filter :find_user, :only => [:suspend, :unsuspend, :destroy, :purge]
  # Protect these actions behind an admin login
  # before_filter :admin_required, :only => [:suspend, :unsuspend, :destroy, :purge]
  before_filter :check_administrator_role, :only => [:index,
                                      :suspend, :unsuspend, :destroy, :purge]
  
  # only an administrator should see all the users
  def index
    @users = User.find(:all)
  end
  
  # users can view their own profile, administrators can view any
  def show
  end

  # render new.rhtml
  def new
    @user = User.new
  end
 
  def create
    logout_keeping_session!
    @user = User.new(params[:user])
    @user.register! if @user && @user.valid?
    success = @user && @user.valid?
    if success && @user.errors.empty?
            redirect_back_or_default('/')
      flash[:notice] = "Thanks for signing up!  We're sending you an email with your activation code."
    else
      flash[:error]  = "Please check for errors."
      render :action => 'new'
    end
  end

  # users can edit their own profile, administrators can edit any
  def edit
  end

  # users can update their own profile, administrators can update any
  def update
    if @user.update_attributes(params[:user])
      flash[:notice] = "User updated"
      redirect_to user_path(@user)
    else
      render :action => 'edit'
    end
  end
  
  def activate
    logout_keeping_session!
    user = User.find_by_activation_code(params[:activation_code]) unless params[:activation_code].blank?
    case
    when (!params[:activation_code].blank?) && user && !user.active?
      user.activate!
      flash[:notice] = "Signup complete! Please sign in to continue."
      redirect_to '/login'
    when params[:activation_code].blank?
      flash[:error] = "The activation code was missing.  Please follow the URL from your email."
      redirect_back_or_default('/')
    else 
      flash[:error]  = "We couldn't find a user with that activation code -- check your email? Or maybe you've already activated -- try signing in."
      redirect_back_or_default('/')
    end
  end

  # only for an administrator (disable a user)
  def suspend
    @user.suspend! 
    redirect_to users_path
  end

  # only for an administrator (enable a user)
  def unsuspend
    @user.unsuspend! 
    redirect_to users_path
  end

  # only for an administrator (same as purge, removes a user completely)
  def destroy
    @user.delete!
    redirect_to users_path
  end

  # only for an administrator (same as destroy, removes a user completely)
  def purge
    @user.destroy
    redirect_to users_path
  end
  
protected

  def find_user
    @user = User.find(params[:id])
  end
  
  def find_user_or_current_user
    if current_user.has_role?('administrator')
      @user = User.find(params[:id])
    else
      @user = current_user
    end
  end
end
