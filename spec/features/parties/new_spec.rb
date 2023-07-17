# When I visit the new viewing party page (/users/:user_id/movies/:movid_id/viewing-party/new, where :user_id is a valid user's id),
# I should see the name of the movie title rendered above a form with the following fields:

#  Duration of Party with a default value of movie runtime in minutes; a viewing party should NOT be created if set to a value less than the duration of the movie
#  When: field to select date
#  Start Time: field to select time
#  Checkboxes next to each existing user in the system
#  Button to create a party
# Details When the party is created, the user should be redirected back to the dashboard where the new event is shown. The event should also be listed on any other user's dashbaords that were also invited to the party.


# As a user,
# When I visit a user dashboard,
# I should see the viewing parties that the user has been invited to with the following details:

# Movie Image
# Movie Title, which links to the movie show page
# Date and Time of Event
# who is hosting the event
# list of users invited, with my name in bold
# I should also see the viewing parties that the user has created with the following details:

# Movie Image
# Movie Title, which links to the movie show page
# Date and Time of Event
# That I am the host of the party
# List of friends invited to the viewing party

require 'rails_helper'

RSpec.describe 'New Viewing Page', type: :feature do
  before(:each) do
    @user1 = User.create!(name: 'Sarah', email: 'sarah@gmail.com', password_digest: 'password1')
    @user2 = User.create!(name: 'James', email: 'James@gmail.com', password_digest: 'password1')
    @user3 = User.create!(name: 'Jimi', email: 'Jimi@gmail.com', password_digest: 'password1')

    movies = SearchFacade.new.movies
    @movie = movies.first
    visit new_viewing_party_path(@user1, @movie.id)
  end  
  describe "new viewing party form page" do
    it "displays form fields", :vcr do
      expect(current_path).to eq(new_viewing_party_path(@user1, @movie.id))

      expect(page).to have_content("#{@movie.title}")

      expect(page).to have_content("Duration of Viewing Party in Minutes")
      expect(page).to have_field(:duration)

      expect(page).to have_field("When is the viewing party")
      expect(page).to have_field(:date)

      expect(page).to have_content("Start Time")
      expect(page).to have_field(:time)
      
      expect(page).to have_content("#{@user2.name}")

      expect(page).to have_button("Create Party")

    end

    it "can create a new viewing party", :vcr do
      fill_in :duration, with: "175"
      fill_in :date, with: '2023/07/09'
      fill_in :time, with: '9:00'
      check @user2.id
      
      click_button("Create Party")

      

      expect(current_path).to eq(user_path(@user1))
     
      # expect(page).to have_content("#{@movie.title}")
      # expect(page).to have_link("#{@movie.title}")

      expect(page).to have_content("2023-07-09")
      expect(page).to have_content("Saturday, January 1, 2000")

      
      expect(page).to have_content("#{@user1.name}")
      # expect(page).to have_content("#{@user2.name}")





    end  

    xit 'cannot be less than movie runtime', :vcr do
      fill_in :duration, with: '174'

      click_button('Create Party')

      expect(current_path).to eq(new_viewing_party_path(@user1, @movie.id))
      
    end
  end  
end  