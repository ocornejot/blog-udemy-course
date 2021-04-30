require 'rails_helper'

RSpec.feature 'Signing in users' do
  before do
    @user = User.create!(email: 'user@example.com', password: 'secret')

    visit '/'
    click_link 'Sign in'
    fill_in "Email", with: @user.email
    fill_in "Password", with: @user.password
    click_button 'Log in'
  end

  scenario do
    visit '/'
    click_link 'Signout'

    expect(page).to have_content('Signed out successfully')
    expect(page).not_to have_content('Signout')
  end
end