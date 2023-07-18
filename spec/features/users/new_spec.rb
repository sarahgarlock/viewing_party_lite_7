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

    context 'happy path' do
      it 'once user registers they are taken to the users dashboard' do
        fill_in 'Name', with: 'Jonah Hill'
        fill_in 'Email Address', with: 'Jhill@gmail.com'
        fill_in 'Password:', with: 'password'
        fill_in 'Password Confirmation:', with: 'password'
        click_button 'Register'

        created_user = User.last
        expect(current_path).to eq(user_path(created_user))
      end
    end

    context 'sad path' do
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
        fill_in 'Password:', with: 'password'
        fill_in 'Password Confirmation:', with: 'password'
        click_button 'Register'

        expect(page).to have_content("Email has already been taken")
        expect(current_path).to eq(register_path)
      end

      it 'displays flash error if password and password confirmation do not match' do
        fill_in 'Name', with: 'Jonah Hill'
        fill_in 'Email Address', with: 'Jhill@gmail.com'
        fill_in 'Password:', with: 'password'
        fill_in 'Password Confirmation:', with: 'password1'
        click_button 'Register'

        expect(page).to have_content("Password confirmation doesn't match Password")
        expect(current_path).to eq(register_path)
      end

      it 'displays flash error if name is not filled in' do
        fill_in 'Name', with: ''
        fill_in 'Email Address', with: 'name@gmail.com'
        fill_in 'Password:', with: 'password'
        fill_in 'Password Confirmation:', with: 'password'
        click_button 'Register'

        expect(page).to have_content("Name can't be blank")
        expect(current_path).to eq(register_path)
      end

      it 'displays flash error if email is not filled in' do
        fill_in 'Name', with: 'Jonah Hill'
        fill_in 'Email Address', with: ''
        fill_in 'Password:', with: 'password'
        fill_in 'Password Confirmation:', with: 'password'
        click_button 'Register'

        expect(page).to have_content("Email can't be blank")
        expect(current_path).to eq(register_path)
      end

      it 'displays flash error if password is not case sensitive' do
        fill_in 'Name', with: 'Jonah Hill'
        fill_in 'Email Address', with: 'Jhill@gmail.com'
        fill_in 'Password:', with: 'password'
        fill_in 'Password Confirmation:', with: 'Password'
        click_button 'Register'

        expect(page).to have_content("Password confirmation doesn't match Password")
        expect(current_path).to eq(register_path)
      end
    end
  end
end