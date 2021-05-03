require 'rails_helper'

RSpec.feature "Listing Articles" do

  before do
    @user = User.create!(email: 'user@example.com', password: 'secret')
    @article1 = Article.create(title: "The first article", body: "Incididunt cupidatat minim culpa occaecat.", user: @user)
    @article2 = Article.create(title: "The second article", body: "Fugiat id nisi ex in amet eu sunt consequat esse aute tempor id.", user: @user)
  end

  scenario "with articles created and user not signed in" do
    visit "/"

    expect(page).to have_content(@article1.title)
    expect(page).to have_content(@article1.body)
    expect(page).to have_content(@article2.title)
    expect(page).to have_content(@article2.body)
    expect(page).to have_link(@article1.title)
    expect(page).to have_link(@article2.title)
    expect(page).not_to have_link("New Article")
  end
  
  scenario "A user lists all articles" do
    login_as(@user)
    visit "/"
    
    expect(page).to have_content(@article1.title)
    expect(page).to have_content(@article1.body)
    expect(page).to have_content(@article2.title)
    expect(page).to have_content(@article2.body)
    expect(page).to have_link(@article1.title)
    expect(page).to have_link(@article2.title)
    expect(page).to have_link("New Article")
  end

  scenario "A user has no articles" do
    Article.delete_all
    visit "/"

    expect(page).not_to have_content(@article1.title)
    expect(page).not_to have_content(@article1.body)
    expect(page).not_to have_content(@article2.title)
    expect(page).not_to have_content(@article2.body)
    expect(page).not_to have_link(@article1.title)
    expect(page).not_to have_link(@article2.title)

    within("h1#no-articles") do
      expect(page).to have_content("No Articles Created")
    end
  end

end