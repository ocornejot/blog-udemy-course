require 'rails_helper'

RSpec.feature 'Deleting an Article' do
  before do
    @user = User.create!(email: 'user@example.com', password: 'secret')
    @article = Article.create(title: "The first article", body: "Incididunt cupidatat minim culpa occaecat.", user: @user)
  end

  scenario "A user deletes his own article" do
    login_as(@user)
    visit "/"

    click_link @article.title
    click_link "Delete Article"

    expect(page).to have_content("Article has been deleted")
    expect(current_path).to eq(articles_path)
  end
end