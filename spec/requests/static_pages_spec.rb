# encoding: utf-8

require 'spec_helper'

describe "Static pages" do
  subject { page }

  describe "Home page" do
    before { visit root_path }

    it { should have_content('Ebara 4th') }
    it { should have_title(full_title('')) }
    it { should_not have_title('| Home') }

    describe "for signed-in users" do
      let(:user) { FactoryGirl.create(:user) }
      before do
    #    FactoryGirl.create(:document, user: user, name: "Name1",
    #                          description: "Des1",
    #                          data: "Data1",
    #                          content_type: "text/plain")
    #    FactoryGirl.create(:document, user: user, name: "Name2",
    #                          description: "Des2",
    #                          data: "Data2",
    #                          content_type: "text/plain")
        sign_in user
        visit root_path
      end

    #  it "should render the user's document" do
    #    user.documents.each do |item|
    #      expect(page).to have_link("Download")
    #    end
    #  end
    end
  end

  describe "Help page" do
    before { visit help_path }

    it { should have_content('Help') }
    it { should have_title(full_title('Help')) }
  end

  describe "About page" do
    before { visit about_path }

    it { should have_content('About') }
    it { should have_title(full_title('About')) }
  end

  describe "Album page" do
    before { visit album_path }

    it { should have_content('Album') }
    it { should have_title(full_title('Album')) }
  end

  it "should have the right links on the layout" do
    visit root_path
    click_link "Album"
    expect(page).to have_title(full_title('Album'))
    click_link "About"
    expect(page).to have_title(full_title('About'))
    click_link "Help"
    expect(page).to have_title(full_title('Help'))
    click_link "Home"
    click_link "Sign in now!"
    expect(page).to have_title(full_title('Sign in'))
  #  click_link "Documents"
  #  expect(page).to have_title(full_title('All documents'))
    #click_link "kame docs"
    #expect(page).to # ここにコードを記入
  end  
end
