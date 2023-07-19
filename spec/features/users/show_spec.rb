require 'rails_helper'

RSpec.describe 'Users Show Page', type: :feature do
  before(:each) do
    @user = User.create!(name: "Ben Dover", email: 'bendover@gmail.com', password: 'password')
  
    visit root_path
  
    click_link "Log In"
  
    fill_in :email, with: @user.email
    fill_in :password, with: @user.password
    click_button "Log In"
  end

  describe 'As a visitor, when I visit a user show page' do
    it 'displays the user name at the top of the page' do
      expect(page).to have_content("Welcome, #{@user.name}!")
      expect(current_path).to eq(user_path(@user))
    end

    it 'displays a button to Discover Movies and redirects to that page' do
      expect(page).to have_button('Discover Movies')
      click_button 'Discover Movies'

      expect(current_path).to eq(discover_path(@user))
    end

    it 'displays a section that lists viewing parties' do
      expect(page).to have_content('Viewing Parties')
    end
  end
end
