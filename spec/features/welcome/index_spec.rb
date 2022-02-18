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

    it 'list of existing users which link to the users dashboard' do
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
      
      click_on "#{user1.email}'s Dashboard"
      expect(current_path).to eq(dashboard_path)

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
  end
end
