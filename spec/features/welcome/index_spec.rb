require 'rails_helper'

describe 'welcome page' do

  describe 'display' do
    it 'title of application' do
      visit root_path
      expect(page).to have_content("Viewing Party")
    end

    it 'button to create a new user' do
      visit root_path
      click_button 'Create a New User'
      expect(current_path).to eq('/register')
    end

    xit 'list of existing users which link to the users dashboard' do
      user = User.create(name:'Devin', email:'devin@faker.net', password: '123fake', password_confirmation: '123fake')
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit root_path
      click_on "#{user.email}'s Dashboard"
      expect(current_path).to eq(dashboard_path)
    end

    it 'header link to go back to landing page' do
      user1 = User.create(name:'Devin', email:'devin@faker.net', password: '123fake', password_confirmation: '123fake')
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user1)
      visit root_path
      click_on 'Home'
      expect(current_path).to eq('/')
    end

    it 'has a link to log in' do
      visit root_path
      expect(page).to have_button("Log In")
      click_on("Log In")
      expect(current_path).to eq('/login')
    end
  end

  describe 'visitor/non-registered users' do
    it 'does not display the a list of existing users' do
      visit root_path

      expect(page).to_not have_content("Existing Users")
      expect(page).to have_content("Log in or register to join the party!")
    end

    it 'If i am registered, the page displays a list of email addresses, not show page links' do
      user1 = User.create(name:'Devin', email:'devin@faker.net', password: '123fake', password_confirmation: '123fake')
      user2 = User.create(name:'Eric', email:'eric@faker.net', password: '123fake', password_confirmation: '123fake')
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user1)
      visit root_path

      expect(page).to_not have_link("eric@faker.net")
      expect(page).to have_content("eric@faker.net")
    end

    it 'displays a message telling me I must log in to access a dashboard' do
      visit root_path
      expect(page).to_not have_content("You must be logged in or registered to access the dashboard")

      click_on("Dashboard")
      expect(page).to have_content("You must be logged in or registered to perform this action")
    end
  end
end
