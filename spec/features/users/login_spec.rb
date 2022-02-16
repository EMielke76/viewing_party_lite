require 'rails_helper'

RSpec.describe 'login form page' do
  before :each do
    visit login_path
  end

  let!(:bob) { User.create!(name: "Bob Barker", email: "thepriceiswrong@cbs.net", password: "Happys4B1tch", password_confirmation: "Happys4B1tch") }

  it 'has a form for email and password submission' do
    expect(page).to have_field(:email)
    expect(page).to have_field(:password)
    expect(page).to have_button("Login")
  end

  context 'happy path' do
    it 'takes a user to their dashboard on successful login' do
      fill_in :email, with: "thepriceiswrong@cbs.net"
      fill_in :password, with: "Happys4B1tch"
      click_on("Login")

      expect(current_path).to eq("/users/#{bob.id}/dashboard")
    end
  end

  context 'sad path' do
    it 'displays an error if password is invalid' do
      fill_in :email, with: "thepriceiswrong@cbs.net"
      fill_in :password, with: "Happys4Botch"
      click_on("Login")

      expect(current_path).to eq(login_path)
      expect(page).to have_content("Invalid email or password")
    end

    it 'displays an error if email is invalid' do
      fill_in :email, with: "thepriceisright@cbs.net"
      fill_in :password, with: "Happys4Bitch"
      click_on("Login")

      expect(current_path).to eq(login_path)
      expect(page).to have_content("Invalid email or password")
    end
  end
end
