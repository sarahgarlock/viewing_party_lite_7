require 'rails_helper'

RSpec.describe '/', type: :feature do
  before(:each) do
    @user1 = User.create!(name: "Sarah", email: "Sarah@gmail.com", password_digest: 'password1')
    @user2 = User.create!(name: "Jimmy", email: "Jimmy@gmail.com", password_digest: 'password1')
    @user3 = User.create!(name: "Alex", email: "Alex@gmail.com", password_digest: 'password1')
    @user4 = User.create!(name: "John", email: "John@gmail.com", password_digest: 'password1')
    visit root_path
  end

  describe "User visits root path" do
    it "should display title of application" do
      expect(page).to have_content("Viewing Party")
    end

    it "should display button to create a new user" do
      expect(page).to have_button("Create New User")
    end

    it "should display existing users emails if signed in" do
      user = User.create!(name: "Ben Dover", 
                          email: 'bendover@gmail.com',
                          password: 'password')
        
      visit login_path
      
      fill_in :email, with: user.email
      fill_in :password, with: user.password
      
      click_button "Log In"

      visit root_path
      
      within("#existing-users") do
        expect(page).to have_content("#{@user1.email}")
        expect(page).to have_content("#{@user2.email}")
        expect(page).to have_content("#{@user3.email}")
        expect(page).to have_content("#{@user4.email}")
        expect(page).to have_content("#{user.email}")
      end
    end

    it "should have a nav home page link" do
      expect(page).to have_link("Home")
    end
  end 

  describe 'visitor visits root path' do
    it 'should not display existing users' do
      expect(page).to_not have_content("Existing Users")
      expect(page).to_not have_content("Sarah")
      expect(page).to_not have_content("Jimmy")
    end
  end
end