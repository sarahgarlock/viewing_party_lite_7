require 'rails_helper'

RSpec.describe "Logging In", type: :feature do
  context 'happy path' do
    it 'can log in with valid credentials' do
      user = User.create!(name: "Ben Dover", email: 'bendover@gmail.com', password: 'password')

      visit root_path

      expect(page).to have_link("Log In")
      click_link "Log In"

      expect(current_path).to eq(login_path)

      fill_in :email, with: user.email
      fill_in :password, with: user.password
      click_button "Log In"

      expect(page).to have_content("Welcome, #{user.name}!")
      expect(current_path).to eq(user_path(user))
    end
  end

  context 'sad path' do
    it 'cannot log in with invalid credentials' do
      user = User.create!(name: "Ben Dover", email: 'bendover@gmail.com', password: 'password')

      visit login_path

      fill_in :email, with: user.email
      fill_in :password, with: "wrongpassword"

      click_button "Log In"

      expect(page).to have_content("Invalid credentials. Please try again.")
      expect(current_path).to eq(login_path)
    end
  end
end

