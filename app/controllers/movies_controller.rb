class MoviesController < ApplicationController
  def index
    current_user
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
    current_user
    movie = MovieFacade.new
    @movie = movie.find_film(params[:id])
  end
end
