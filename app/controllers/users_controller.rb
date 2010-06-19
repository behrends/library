class UsersController < ApplicationController
  before_filter :login_required
  before_filter :check_user

  # render new.rhtml
  def new
    @pagetitle = "Create user"
  end

  def create
    cookies.delete :auth_token
    # protects against session fixation attacks, wreaks havoc with 
    # request forgery protection.
    # uncomment at your own risk
    # reset_session
    @user = User.new(params[:user])
    @user.save
    if @user.errors.empty?
      self.current_user = @user
      redirect_back_or_default('/')
      flash[:notice] = "Created user successfully!"
    else
      @pagetitle = "Create user"
      render :action => 'new'
    end
  end

  private 

  def check_user
    @current_user.login == "erik" || access_denied
  end
end
