require 'rails_helper'

describe 'welcome page' do
  before do
    @user1 = User.create(name:'Devin', email:'devin@faker.net', password: '123fake', password_confirmation: '123fake')
    @user2 = User.create(name:'Eric', email:'eric@faker.net', password: '123fake', password_confirmation: '123fake')
    visit root_path
  end

  describe 'display' do
    it 'title of application' do
      expect(page).to have_content("Viewing Party")
    end

    it 'button to create a new user' do
      click_button 'Create a New User'
      expect(current_path).to eq('/register')
    end

    it 'list of existing users which link to the users dashboard' do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user1)
      click_on "#{@user1.email}'s Dashboard"
      expect(current_path).to eq(dashboard_path)

      visit root_path
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user2)
      click_on "#{@user2.email}'s Dashboard"
      expect(current_path).to eq(dashboard_path)
    end

    it 'header link to go back to landing page' do
      click_on 'Home'
      expect(current_path).to eq('/')
      
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user1)
      click_on "#{@user1.email}'s Dashboard"
      expect(current_path).to eq(dashboard_path)

      click_on 'Home'
      expect(current_path).to eq('/')
    end

    it 'has a link to log in' do
      expect(page).to have_button("Log In")
      click_on("Log In")
      expect(current_path).to eq('/login')
    end
  end
end
