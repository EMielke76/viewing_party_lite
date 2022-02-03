class MoviesController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    movie = MovieFacade.new
    if params[:search] && params[:search].blank?
      []
    elsif params[:search]
      @movie = movie.movie_search(params[:search])
    else
      @movie= movie.top_40_movies
    end
  end

  def show
  end 
end
