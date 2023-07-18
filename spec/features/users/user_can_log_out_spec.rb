require 'rails_helper'

RSpec.describe "Logging Out", type: :feature do
  context 'happy path' do
    it 'can log out and return to landing page' do
      user = User.create!(name: "Ben Dover", 
                          email: 'bendover@gmail.com',
                          password: 'password')

      visit login_path

      fill_in :email, with: user.email
      fill_in :password, with: user.password
      click_button "Log In"

      expect(page).to_not have_link("Log In")
      expect(page).to_not have_link("Create Account")
      expect(page).to have_link("Log Out")

      click_link "Log Out"
      expect(current_path).to eq(root_path)
      expect(page).to have_content("You have successfully logged out.")
      expect(page).to have_link("Log In")
      expect(page).to have_button("Create New User")
      expect(page).to_not have_link("Log Out")
    end
  end
end
