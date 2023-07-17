require 'rails_helper'

RSpec.describe "/register", type: :feature do
  before(:each) do
    visit register_path
  end
  describe "As a visitor, when I visit the user registration page" do
    it 'displays form with name field' do
      expect(page).to have_field("Name:")
    end

    it 'displays form with email field' do
      expect(page).to have_field("Email Address:")
    end

    it 'displays form with password field' do
      expect(page).to have_field("Password:")
    end

    it 'displays form with password confirmation field' do
      expect(page).to have_field("Password Confirmation:")
    end

    it 'display form with Register Button' do
      expect(page).to have_button("Register")
    end

    it 'once user registers they are taken to the users dashboard' do
      fill_in 'Name', with: 'Jonah Hill'
      fill_in 'Email Address', with: 'Jhill@gmail.com'
      fill_in 'Password:', with: 'password'
      fill_in 'Password Confirmation:', with: 'password'
      click_button 'Register'

      created_user = User.last
      expect(current_path).to eq(user_path(created_user))
    end

    it "displays flash error if email is not unique" do
      fill_in 'Name', with: 'Jonah Hill'
      fill_in 'Email Address', with: 'Jhill@gmail.com'
      fill_in 'Password:', with: 'password'
      fill_in 'Password Confirmation:', with: 'password'
      click_button 'Register'

      created_user = User.last
      expect(current_path).to eq(user_path(created_user))

      visit register_path

      fill_in 'Name', with: 'James Hill'
      fill_in 'Email Address', with: 'Jhill@gmail.com'
      click_button 'Register'

      expect(page).to have_content("Email Address Must Be Unique")
      expect(current_path).to eq(register_path)
    end
  end
end