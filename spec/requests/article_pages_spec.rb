# encoding: utf-8

require 'spec_helper'

describe "Article Pages" do
  subject { page }

  let(:user) { FactoryGirl.create(:admin) }
  before { sign_in user }
  
  describe "show page" do
    let(:article) { FactoryGirl.create(:article) }
    let!(:p1) { FactoryGirl.create(:picture, article: article, 
                                     image_file_name: "picture1.png" ,
                                     image_content_type: "image/png") }
    let!(:p2) { FactoryGirl.create(:picture, article: article, 
                                     image_file_name: "picture2.png" ,
                                     image_content_type: "image/png") }
    before { visit article_path(article) }

    it { should have_content(article.title) }
    it { should have_title(article.title) }

    describe "pictures" do
      #it { should have_content(p1.id) }
      #it { should have_content(p2.id) }
      #it { should have_content(article.pictures.count) }
      it { should have_selector('img') }
    end
  end
    
  describe "index" do
    before do
      sign_in FactoryGirl.create(:user)
      FactoryGirl.create(:article, title: "Bob", content: "bob@example.com")
      FactoryGirl.create(:article, title: "Ben", content: "ben@example.com")
      visit articles_path
    end

    it { should have_title('お知らせ') }
    it { should have_content('お知らせ') }

    it "should list each article" do
      Article.all.each do |article|
        expect(page).to have_selector('li', text: article.title)
      end
    end
  end

  describe "new article" do

    before { visit new_article_path }

    let(:submit) { "お知らせ登録" }

    describe "with invalid information" do
      it "should not create a article" do
        expect { click_button submit }.not_to change(Article, :count)
      end
    end

    describe "with valid information" do
      before do
        fill_in "題名",     with: "Example Article"
        #fill_in "作成者ID", with: "2"
        #fill_in "日付",     with: "20150315"
        fill_in "内容",     with: "Example content"
      end

      it "should create a article" do
        expect { click_button submit }.to change(Article, :count).by(1)
      end
    end
  end

  describe "edit" do
    let(:article) { FactoryGirl.create(:article) }
    before { visit edit_article_path(article) }

    describe "page" do
      it { should have_content("お知らせ更新") }
      it { should have_title("お知らせ更新") }
    end

    describe "with invalid information" do
      before do
        fill_in "題名",     with: " "
        click_button "お知らせ更新" 
      end
      
      it { should have_content('error') }
    end

    describe "with valid information" do
      let(:new_title)   { "New title" }
      let(:new_content) { "New content" }
      before do
        fill_in "題名",     with: new_title
        fill_in "内容",     with: new_content
        click_button "お知らせ更新"
      end

      it { should have_title(new_title) }
      it { should have_selector('div.alert.alert-success') }
      specify { expect(article.reload.title).to  eq new_title }
      specify { expect(article.reload.content).to eq new_content }
    end
  end
end
