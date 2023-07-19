require 'rails_helper'

RSpec.describe 'Users Discover Page', type: :feature do
  before(:each) do
    @user = User.create!(name: "Ben Dover", email: 'bendover@gmail.com', password: 'password')

    visit root_path
  
    click_link "Log In"
  
    fill_in :email, with: @user.email
    fill_in :password, with: @user.password
    click_button "Log In"
  end
  describe 'As a user, when I visit the User Dashboard and I click on "Discover Movies"' do
    it 'redirects me to a discover movies page' do
      expect(current_path).to eq(user_path(@user))

      click_button 'Discover Movies'

      expect(current_path).to eq(discover_path(@user))
    end
  end

  describe 'As a user, when I visit the User Discover Page' do
    it 'displays button to Discover Top Rated Movies' do
      visit discover_path(@user)
      expect(page).to have_button("Discover Top Rated Movies")
    end

    it 'display a search by movie title text field with search button' do
      visit discover_path(@user)
      expect(page).to have_field("Search by Movie Title")
      expect(page).to have_button("Search")
    end

    it 'redirect to movies result page after clicking Discover Top Rated Movies or search button', :vcr do
      visit discover_path(@user)

      click_button("Discover Top Rated Movies")

      expect(current_path).to eq(movies_path(@user))

      visit discover_path(@user)

      fill_in :search, with: 'Batman Forever'
      click_button "Search"

      expect(current_path).to eq(search_path(@user))
    end
  end
end