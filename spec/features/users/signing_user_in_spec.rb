require 'rails_helper'

RSpec.feature 'Signing out logged users' do
  before do
    @user = User.create!(email: 'user@example.com', password: 'secret')
  end

  scenario 'with valid credentials' do
    visit '/'
    click_link 'Sign in'
    fill_in "Email", with: @user.email
    fill_in "Password", with: @user.password
    click_button 'Log in'

    expect(page).to have_content('Signed in successfully')
    expect(page).to have_content("Signed in as #{@user.email}")
    expect(page).not_to have_link("Sign in")
    expect(page).not_to have_link("Sign up")
  end

  scenario 'with invalid credentials' do
    visit '/'
    click_link 'Sign in'
    fill_in "Email", with: ''
    fill_in "Password", with: ''
    click_button 'Log in'

    expect(page).to have_content('Invalid Email or password')
  end
end