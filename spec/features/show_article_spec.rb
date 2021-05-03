require 'rails_helper'

RSpec.feature "Showing Articles" do

  before do
    @user = User.create!(email: 'user@example.com', password: 'secret')
    @user2 = User.create!(email: 'user2@example.com', password: 'secret')
    @article = Article.create(title: "The first article", body: "Incididunt cupidatat minim culpa occaecat.", user: @user)
  end

  scenario "to non-signed in user hide the Edit and Delete buttons" do
    login_as(@user2)
    visit "/"

    click_link @article.title

    expect(page).to have_content(@article.title)
    expect(page).to have_content(@article.body)
    expect(current_path).to eq(article_path(@article))

    expect(page).not_to have_link("Edit Article")
    expect(page).not_to have_link("Delete Article")
  end

  scenario "to non-owner hide the Edit and Delete buttons" do
    login_as(@user2)
    visit "/"

    click_link @article.title

    expect(page).to have_content(@article.title)
    expect(page).to have_content(@article.body)
    expect(current_path).to eq(article_path(@article))

    expect(page).not_to have_link("Edit Article")
    expect(page).not_to have_link("Delete Article")
  end

  scenario "A signed in owner sees both the Edit and Delete buttons" do
    login_as(@user)
    visit "/"
    click_link @article.title

    expect(page).to have_content(@article.title)
    expect(page).to have_content(@article.body)
    expect(current_path).to eq(article_path(@article))

    expect(page).to have_link("Edit Article")
    expect(page).to have_link("Delete Article")
  end
end