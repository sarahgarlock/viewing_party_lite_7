class UsersController < ApplicationController
  # def index
  #   binding.pry
  # end
  def show
    @user = User.find(params[:id])
 
    # movie_id = @user.parties.first.movie_id
    # @movie = SearchFacade.new(params[movie_id]).movies.first
    # @party = @user.parties.first
  end

  def new
    @user = User.new
  end

  def create
    user = User.new(user_params)
    if user.save
      redirect_to user_path(user)
      flash[:success] = "Welcome, #{user.name}"
    else
      redirect_to register_path
      flash[:error] = "Email Address Must Be Unique"
    end
  end
  

  private  
  
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end