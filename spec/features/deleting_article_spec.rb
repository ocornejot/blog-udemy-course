require 'rails_helper'

RSpec.feature 'Deleting an Article' do
  before do
    @user = User.create!(email: 'user@example.com', password: 'secret')
    login_as(@user)
    @article = Article.create(title: "The first article", body: "Incididunt cupidatat minim culpa occaecat.", user: @user)
  end

  scenario "A user deletes an article" do
    visit "/"

    click_link @article.title
    click_link "Delete Article"

    expect(page).to have_content("Article has been deleted")
    expect(current_path).to eq(articles_path)
  end
end