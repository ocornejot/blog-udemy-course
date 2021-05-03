require 'rails_helper'

RSpec.describe "Articles", type: :request do

  before do
    @user = User.create!(email: 'user@mail.com', password: 'secret')
    @user2 = User.create!(email: 'user2@mail.com', password: 'secret')
    @article = Article.create!(title: 'title', body: 'Laboris consequat elit exercitation cillum aute eu eiusmod.', user: @user)
  end

  describe "GET /index" do
    it "returns http success" do
      get "/articles"
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /articles/:id' do
    context 'with existing article' do
      before { get "/articles/#{@article.id}" }

      it "handles existing article" do
        expect(response.status).to eq 200
      end
    end

    context 'with non-existing article' do
      before { get "/articles/xxxx" }
      it "handles existing article" do
        expect(response.status).to eq 302
        flash_message = "Article you are looking for could not be found"
        expect(flash[:alert]).to eq(flash_message)
      end
    end
  end

  describe 'GET /articles/:id/edit' do
    context 'with non-signed in user' do
      before { get "/articles/#{@article.id}/edit" }

      it "redirects to the signin page" do
        expect(response.status).to eq 302
        flash_message = "You need to sign in or sign up before continuing."
        expect(flash[:alert]).to eq flash_message
      end
    end

    context 'with signed in user who is non-owner' do
      before do
        login_as(@user2)
        get "/articles/#{@article.id}/edit"
      end

      it "redirects to the home page" do
        expect(response.status).to eq 302
        flash_message = "You can only edit your own article."
        expect(flash[:alert]).to eq(flash_message)
      end
    end

    context 'with signed in user as own successful edit' do
      before do
        login_as(@user)
        get "/articles/#{@article.id}/edit"
      end

      it "successfully edits article" do
        expect(response.status).to eq 200
      end
    end
  end

  describe 'DELETE /articles/:id' do
    context 'with user deleting his own article' do
      before do 
        login_as(@user)
        delete "/articles/#{@article.id}" 
      end

      it "successfully deletes an existing article" do
        expect(response.status).to eq 302
        flash_message = "Article has been deleted"
        expect(flash[:success]).to eq(flash_message)
      end
    end

    context 'with other user trying to delete other user article' do
      before do 
        login_as(@user2)
        delete "/articles/#{@article.id}" 
      end

      it "redirects to the home page" do
        expect(response.status).to eq 302
        flash_message = "You can only delete your own article."
        expect(flash[:alert]).to eq(flash_message)
      end
    end
  end
end
