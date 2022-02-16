require 'rails_helper'

RSpec.describe 'Registration form page' do

  before :each do
    visit register_path
  end

  it 'displays a form to register a new user' do

    expect(page).to have_field(:name)
    expect(page).to have_field(:email)
    expect(page).to have_field(:password)
    expect(page).to have_field(:password_confirmation)
    expect(page).to have_button("Create New User")
  end

  context 'happy path' do
    it 'takes the user to its dashboard on successful registration' do
      fill_in :name, with: 'Bob Barker'
      fill_in :email, with: 'BobBarker@ThePriceIsWrong.net'
      fill_in :password, with: 'HappysABitch'
      fill_in :password_confirmation, with: 'HappysABitch'

      click_on("Create New User")
      expect(current_path).to eq("/users/#{User.last.id}/dashboard")
    end
  end

  context 'sad path' do
    it 'returns an error if name is not filled out' do
      fill_in :email, with: 'BobBarker@ThePriceIsWrong.net'
      fill_in :password, with: 'HappysABitch'
      fill_in :password_confirmation, with: 'HappysABitch'

      click_on("Create New User")
      expect(current_path).to eq(register_path)
      expect(page).to have_content("Name cannot be blank")
    end

    it 'returns an error if email is not unique' do
      fill_in :name, with: 'Bob Barker'
      fill_in :email, with: 'BobBarker@ThePriceIsWrong.net'
      fill_in :password, with: 'HappysABitch'
      fill_in :password_confirmation, with: 'HappysABitch'

      click_on("Create New User")

      visit register_path
      fill_in :name, with: 'Jeff Jebowski'
      fill_in :email, with: 'BobBarker@ThePriceIsWrong.net'
      fill_in :password, with: 'Abide123'
      fill_in :password_confirmation, with: 'Abide123'

      click_on("Create New User")
      expect(current_path).to eq(register_path)
      expect(page).to have_content('Email address is blank/already in use.')
    end

    it 'returns an error if passwords do not match' do
      fill_in :name, with: 'Bob Barker'
      fill_in :email, with: 'BobBarker@ThePriceIsWrong.net'
      fill_in :password, with: 'HappysABitch'
      fill_in :password_confirmation, with: 'HappysABotch'

      click_on("Create New User")
      expect(current_path).to eq(register_path)
      expect(page).to have_content('Password does not match!')
    end
  end
end
