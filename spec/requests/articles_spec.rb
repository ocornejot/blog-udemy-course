require 'rails_helper'

RSpec.describe "Articles", type: :request do

  before do
    @article = Article.create(title: 'title', body: 'Laboris consequat elit exercitation cillum aute eu eiusmod.')
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
end
