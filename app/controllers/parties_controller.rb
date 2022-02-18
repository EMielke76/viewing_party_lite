class PartiesController < ApplicationController
  def new
    movie = MovieFacade.new
    @movie = movie.find_film(params[:movie_id]).first
    @users = User.all
  end

  def create
    party = Party.new(party_params)
    host = current_user.id
    user_ids = params[:users]
    genie = MovieFacade.new
    movie = genie.find_film(params[:movie_id]).first
    
    if party.length >= movie.runtime && party.save
      party.host_id = host
      user_ids.each do |id|
        invitee = User.find(id.to_i)
        party.users << invitee
      end
      redirect_to "/dashboard"
    else
      redirect_to "/movies/#{params[:movie_id]}/parties/new"
      flash[:alert] = "Error: Party duration cannot be shorter than movie runtime"
    end
  end

    private

      def party_params
        params.permit(:length, :date, :start_time, :host_id, :movie_id)
      end
end
