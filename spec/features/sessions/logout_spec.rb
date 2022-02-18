require 'rails_helper'

RSpec.describe 'logout' do



  it 'no longer displays login or create account if I am logged in' do
    user = User.create(name:'Eric', email:'eric@faker.net', password: '123fake', password_confirmation: '123fake')
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    visit root_path

    expect(page).to_not have_button("Create a New User")
    expect(page).to_not have_button("Log In")
  end

  it 'displays a link to log out' do
    user = User.create(name:'Eric', email:'eric@faker.net', password: '123fake', password_confirmation: '123fake')
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    visit root_path

    expect(page).to have_button("Log Out")
  end

  it 'displays the login and create account options once I log out' do
    user_1 = User.create(name:'Eric', email:'ericm@faker.net', password: 'BadTouch', password_confirmation: 'BadTouch')
    visit "/login"
    fill_in :email, with: "ericm@faker.net"
    fill_in :password, with: 'BadTouch'
    click_on("Login")

    visit root_path

    expect(page).to_not have_button("Create a New User")
    expect(page).to_not have_button("Log In")
    expect(page).to have_button("Log Out")

    click_on("Log Out")
    expect(current_path).to eq(root_path)
    expect(page).to have_content('Logged out')
    
    expect(page).to have_button("Create a New User")
    expect(page).to have_button("Log In")
    expect(page).to_not have_button("Log Out")
  end
end
