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
end
# As a registered user
# When I visit the landing page `/`
# I see a link for "Log In"
# When I click on "Log In"
# I'm taken to a Log In page ('/login') where I can input my unique email and password.
# When I enter my unique email and correct password 
# I'm taken to my dashboard page