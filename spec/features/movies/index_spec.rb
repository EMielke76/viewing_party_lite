require 'rails_helper'

describe 'Movie Index / Search Results Page' do
  before :each do
    @user = User.create(name:'Eric', email:'eric@faker.net', password: 'BadTouch', password_confirmation: 'BadTouch')
    visit "/login"
    fill_in :email, with: "eric#@faker.net"
    fill_in :password, with: 'BadTouch'
    click_on("Login")
  end

  describe 'display' do
    it 'link back to discover page', :vcr do
      visit movies_path
      click_on 'Discover Page'
      expect(current_path).to eq(discover_path)
    end

    describe 'top 40 movies' do
      it 'button returns 40 movies with highest rating, desc order' do
        VCR.use_cassette('tmdb_top_rated_movies_1&2') do
          visit discover_path
          click_button 'Find Top Rated Movies'
          expect(current_path).to eq(movies_path)
          expect(page).to have_content("The Shawshank Redemption")
        end
      end
    end

    describe 'movie search' do
      it 'can do partial searches for movies that meet params' do
        VCR.use_cassette('tmdb_query_matchers') do
          visit discover_path
          fill_in :search, with: 'Home'
          click_on 'Find Movies'
          expect(current_path).to eq(movies_path)
          within "#movie-634649" do
            expect(page).to have_content("Spider-Man: No Way Home")
          end
        end
      end

      it 'can return message if search left blank', :vcr do
        visit discover_path
        fill_in :search, with: ''
        click_on 'Find Movies'
        expect(current_path).to eq(movies_path)
        expect(page).to have_content("No results found.")
      end

      it 'can return message if search results empty', :vcr do
        visit discover_path
        fill_in :search, with: 'asdf'
        click_on 'Find Movies'
        expect(current_path).to eq(movies_path)
        expect(page).to have_content("No results found.")
      end
    end
  end
end
