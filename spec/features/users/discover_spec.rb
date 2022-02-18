require 'rails_helper'

describe 'Discover Page', type: :feature do
  before do
    @user = User.create(name:'Eric', email:'eric@faker.net', password: 'BadTouch', password_confirmation: 'BadTouch')
    visit "/login"
    fill_in :email, with: "eric#@faker.net"
    fill_in :password, with: 'BadTouch'
    click_on("Login")
    visit discover_path
  end

  describe 'display' do
    it 'Top Rated button' do
      VCR.use_cassette('tmdb_top_rated_movies_1&2') do
        click_button 'Find Top Rated Movies'
        expect(current_path).to eq('/movies')
      end
    end

    it 'form to search movies' do
      VCR.use_cassette('tmdb_query_matchers') do
        fill_in :search, with: 'Home'
        click_on 'Find Movies'
        expect(current_path).to eq('/movies')
      end
    end
  end
end
