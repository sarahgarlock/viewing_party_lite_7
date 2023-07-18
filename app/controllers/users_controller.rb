class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    user = User.new(user_params)
    user[:email] = user[:email].downcase
    if user.save
      redirect_to user_path(user)
      flash[:success] = "Welcome, #{user.name}"
    else
      redirect_to register_path
      flash[:error] = user.errors.full_messages.to_sentence
    end
  end

  def login_form
  end

  def login
    user = User.find_by(email: params[:email].downcase)
    if user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:success] = "Welcome, #{user.name}!"
      redirect_to user_path(user)
    else
      flash[:error] = "Invalid credentials. Please try again."
      redirect_to login_path
    end
  end

  def logout
    session.delete(:user_id)
    flash[:success] = "You have successfully logged out."
    redirect_to root_path
  end
  
  private  
  
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end