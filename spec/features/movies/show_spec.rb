require 'rails_helper'

RSpec.describe 'Movie Show Page' do
  describe 'visitor functions' do
    it 'informs me i must be logged in to create a party', :vcr do
      visit movie_path(278)
      click_on("Create Viewing Party!")
      expect(current_path).to eq(root_path)
      expect(page).to have_content("You must be logged in or registered to perform this action")
    end
  end

  describe 'registered user actions' do
    before :each do
      @user = User.create(name:'Eric', email:'eric@faker.net', password: 'BadTouch', password_confirmation: 'BadTouch')
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
    end

    it 'displays a button to create a viewing party' do
      VCR.use_cassette('tmbd_movie_details_with_credits&reviews') do
        visit movie_path(278)

        expect(page).to have_button("Create Viewing Party!")
        click_on "Create Viewing Party!"
        expect(current_path).to eq("/movies/278/parties/new")
      end
    end

    it 'displays a button to return to the Discover Page', :vcr do
      visit movie_path(278)

      expect(page).to have_button("Return to Discover Page")
      click_on "Return to Discover Page"
      expect(current_path).to eq(discover_path)
    end

    it 'displays the movies attributes', :vcr do
      summary = 'Framed in the 1940s for the double murder of his wife and her lover,'\
       ' upstanding banker Andy Dufresne begins a new life at the Shawshank prison,'\
       ' where he puts his accounting skills to work for an amoral warden. During his'\
       ' long stretch in prison, Dufresne comes to be admired by the other inmates --'\
       ' including an older prisoner named Red -- for his integrity and unquenchable'\
       ' sense of hope.'
       username = "elshaarawy"
       rating = 9.0
      visit movie_path(278)

      expect(page).to have_content("Shawshank Redemption")
      expect(page).to have_content("Details:")
      expect(page).to have_content("Vote Average: 8.7/10")
      expect(page).to have_content("Runtime: 2 hr 22 min")
      expect(page).to have_content("Genre(s):")
      expect(page).to have_content("Drama")
      expect(page).to have_content("Crime")
      expect(page).to have_content("Summary: #{summary}")
      expect(page).to have_content("Cast")

      within("#review_info") do
        expect(page).to have_content("Count of Reviews: 7")
        expect(page).to have_content("Username: #{username}")
        expect(page).to have_content("Rating: #{rating}")
      end
    end
  end
end
