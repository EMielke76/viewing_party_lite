require 'rails_helper'

RSpec.describe 'users dashboard' do

  before :each do
    @user_1 = User.create!(name: "Bob Barker", email: "BobBarker@example.com", password: "123YouAndMe", password_confirmation: "123YouAndMe")
    @user_2 = User.create!(name: "Jeff Lebowski", email: "TheDude@example.com", password: "Abide4Life", password_confirmation: "Abide4Life")
    @user_3 = User.create!(name: "Eyore", email: "ForeverAScone@example.com", password: "4everAlone", password_confirmation: "4everAlone")
    # allow(ApplicationController).to receive(:current_user).and_return(@user)
    visit "/login"
    fill_in :email, with: "BobBarker@example.com"
    fill_in :password, with: "123YouAndMe"
    click_on("Login")
  end

  it 'displays the users name at the top of the page' do
    visit dashboard_path
    expect(page).to have_content("Bob Barker's Dashboard")
  end

  it 'displays a button that links to Discover Movies' do
    visit dashboard_path

    within("#discover_movies") do
      expect(page).to have_button("Discover Movies")
      click_on "Discover Movies"
      expect(current_path).to eq("/discover")
    end
  end

  it 'provides a section where any viewing parties are listed' do
    VCR.use_cassette('tmdb_movie_details_with_credits_reviews') do
      VCR.use_cassette('the_godfather') do
        VCR.use_cassette('image') do
          VCR.use_cassette('image_and_data') do
            party_1 = Party.create!(host_id: @user_1.id, movie_id: 278, length: 142, start_time: "19:00:00", date:  Date.new(2022,04,04))
            party_2 = Party.create!(host_id: @user_3.id, movie_id: 238, length: 175, start_time: "20:00:00", date:  Date.new(2022,04,05))

            Attendee.create!(user: @user_1, party: party_1)
            Attendee.create!(user: @user_2, party: party_1)

            Attendee.create!(user:@user_3, party: party_2)
            Attendee.create!(user:@user_1, party: party_2)

            visit dashboard_path
            #one created party and one invite
            expect(page).to have_content("It's Party Time!")
            expect(page).to have_content("My Parties")

            within("#party_time_host_#{party_1.id}") do
              expect(page).to have_content("Film: The Shawshank Redemption")
              expect(page).to have_content("Date: Mon, April 04, 2022")
              expect(page).to have_content("Time: 07:00PM")
              expect(page).to have_content("Host: Bob Barker")
              expect(page).to have_content("Who's Invited?")
              expect(page).to have_content("Bob Barker")
              expect(page).to have_content("Jeff Lebowski")
            end

            expect(page).to have_content("Parties I've Been Invited To")
            within("#party_time_guest_#{party_2.id}") do
              expect(page).to have_content("Film: The Godfather")
              expect(page).to have_content("Date: Tue, April 05, 2022")
              expect(page).to have_content("Time: 08:00PM")
              expect(page).to have_content("Host: Eyore")
              expect(page).to have_content("Who's Invited?")
              expect(page).to have_content("Bob Barker")
              expect(page).to have_content("Eyore")
            end
          end
        end
      end
    end
  end

  it 'no created parties but one invite', :vcr do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user_2)

    party_1 = Party.create!(host_id: @user_1.id, movie_id: 278, length: 142, start_time: "19:00:00", date:  Date.new(2022,04,04))

    Attendee.create!(user: @user_1, party: party_1)
    Attendee.create!(user: @user_2, party: party_1)

    visit dashboard_path
    #No created parties, one invite
    expect(page).to have_content("It's Party Time!")
    expect(page).to have_content("Parties I've Been Invited To")

    within("#party_time_guest_#{party_1.id}") do
      expect(page).to have_content("Film: The Shawshank Redemption")
      expect(page).to have_content("Date: Mon, April 04, 2022")
      expect(page).to have_content("Time: 07:00PM")
      expect(page).to have_content("Host: Bob Barker")
      expect(page).to have_content("Who's Invited?")
      expect(page).to have_content("Bob Barker")
      expect(page).to have_content("Jeff Lebowski")
    end
    expect(page).to_not have_content("My Parties")
  end

  it 'displays one created party, no invites', :vcr  do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user_3)

    party_2 = Party.create!(host_id: @user_3.id, movie_id: 238, length: 175, start_time: "20:00:00", date:  Date.new(2022,04,05))
    Attendee.create!(user:@user_3, party: party_2)
    Attendee.create!(user:@user_1, party: party_2)


    visit dashboard_path
    #One created party, no invites
    expect(page).to have_content("It's Party Time!")
    expect(page).to have_content("My Parties")

    within("#party_time_host_#{party_2.id}") do
      expect(page).to have_content("Film: The Godfather")
      expect(page).to have_content("Date: Tue, April 05, 2022")
      expect(page).to have_content("Time: 08:00PM")
      expect(page).to have_content("Host: Eyore")
      expect(page).to have_content("Who's Invited?")
      expect(page).to have_content("Bob Barker")
      expect(page).to have_content("Eyore")
    end

    expect(page).to_not have_content("Parties I've Been Invited To")
  end

  it 'links to a movies show page', :vcr do
    party_1 = Party.create!(host_id: @user_1.id, movie_id: 278, length: 142, start_time: "19:00:00", date:  Date.new(2022,04,04))
    Attendee.create!(user: @user_1, party: party_1)


    visit dashboard_path

    within("#party_time_host_#{party_1.id}") do
      expect(page).to have_link("The Shawshank Redemption")
      click_on "The Shawshank Redemption"
      expect(current_path).to eq("/movies/#{party_1.movie_id}")
    end
  end
end
