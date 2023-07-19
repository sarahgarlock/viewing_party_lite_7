class MoviesController < ApplicationController

  def discover
    @user = User.find(params[:id])
  end

  def index
    @user = User.find(params[:id])
    @facade = SearchFacade.new(params[:search])
    
  end
  
  def show
    @user = User.find(params[:user_id])

    @movie = MovieFacade.new(params[:movie_id]).get_movie_details

    @casts = MovieFacade.new(params[:movie_id]).get_cast

    @reviews = MovieFacade.new(params[:movie_id]).get_reviews
  end
end