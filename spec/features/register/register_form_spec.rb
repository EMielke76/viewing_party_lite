require 'rails_helper'

RSpec.describe 'Registration form page' do
  it 'displays a form to register a new user' do
  end

  context 'happy path' do
    it 'takes the user to its dashboard on successful registration' do
    end
  end

  context 'sad path' do
    it 'returns an error if name is not filled out' do
    end

    it 'returns an error if email is not unique' do
    end

    it 'returns an error if passwords do not match' do
    end
  end 
end
