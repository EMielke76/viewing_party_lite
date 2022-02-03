require 'rails_helper'

RSpec.describe MovieService do
  context 'class methods' do
    context "#top_movies" do
      it 'returns movie data', :vcr do
        movie = MovieService.new
        movies = movie.top_movies
        
        expect(movies).to be_a(Array)
        movie_data = movies.first

        expect(movie_data).to have_key(:title)
        expect(movie_data[:title]).to be_a(String)

        expect(movie_data).to have_key(:vote_average)
        expect(movie_data[:vote_average]).to be_a(Float)

        expect(movie_data).to have_key(:id)
        expect(movie_data[:id]).to be_a(Integer)
      end
    end
  end
end