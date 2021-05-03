require 'rails_helper'

RSpec.feature "Adding reviews to Articles" do
  before do
    @user = User.create!(email: 'user@mail.com', password: 'secret')
    @user2 = User.create!(email: 'user2@mail.com', password: 'secret')
    @article = Article.create!(title: 'title', body: 'Laboris consequat elit exercitation cillum aute eu eiusmod.', user: @user)
  end

  scenario 'permits a signed in user to write a review' do
    login_as(@user)
    visit '/'

    click_link(@article.title)
    fill_in "New Comment", with: "An amazing article"
    click_button "Add Comment"

    expect(page).to have_content("Comment has been created")
    expect(page).to have_content("An amazing article")
    expect(current_path).to eq(article_path(@article.id))
  end
end