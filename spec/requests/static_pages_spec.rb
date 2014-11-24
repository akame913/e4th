# encoding: utf-8

require 'spec_helper'

describe "Static pages" do
  subject { page }

  describe "Home page" do
    before { visit root_path }

    it { should have_content('Home') }
    #it { should have_title(full_title('Home')) }
    #it { should_not have_title('| Home') }

    #describe "for signed-in users" do
    #  let(:user) { FactoryGirl.create(:user) }
    #  before do
    #    FactoryGirl.create(:document, user: user, name: "Name1",
    #                          description: "Des1",
    #                          data: "Data1",
    #                          content_type: "text/plain")
    #    FactoryGirl.create(:document, user: user, name: "Name2",
    #                          description: "Des2",
    #                          data: "Data2",
    #                          content_type: "text/plain")
    #    sign_in user
    #    visit root_path
    #  end

    #  it "should render the user's document" do
    #    user.documents.each do |item|
    #      expect(page).to have_link("Download")
    #    end
    #  end
    #end
  end

  describe "Help page" do
    before { visit help_path }

    it { should have_content('Help') }
    #it { should have_title(full_title('Help')) }
  end

  describe "About page" do
    before { visit about_path }

    it { should have_content('About') }
    #it { should have_title(full_title('About')) }
  end

  #it "should have the right links on the layout" do
  #  visit root_path
  #  click_link "About"
  #  expect(page).to have_title(full_title('About Us'))
  #  click_link "Help"
  #  expect(page).to have_title(full_title('Help'))
  #  click_link "Home"
  #  click_link "Sign in now!"
  #  expect(page).to have_title(full_title('Sign in'))
  #  click_link "Documents"
  #  expect(page).to have_title(full_title('All documents'))
    #click_link "kame docs"
    #expect(page).to # ここにコードを記入
  #end  
end
