# encoding: utf-8

require 'spec_helper'

describe "Static pages" do
  subject { page }

  describe "Home page" do
    before { visit root_path }

    #it { should have_content('Ebara 4th') }
    it { should have_title(full_title('')) }
    it { should_not have_title('| ホーム') }

    describe "for signed-in users" do
      let(:user) { FactoryGirl.create(:user) }
      let!(:m1) { FactoryGirl.create(:micropost, user: user, group_id: 1, content: "Foo") }
      let!(:m2) { FactoryGirl.create(:micropost, user: user, group_id: 1, content: "Bar") }

      before do
        sign_in user
        visit root_path
      end

      describe "microposts" do
        it { should have_content(m1.content) }
        it { should have_content(m2.content) }
      end
    end
  end

  #describe "Help page" do
  #  before { visit help_path }
  #
  #  it { should have_content('ヘルプ') }
  #  it { should have_title(full_title('ヘルプ')) }
  #end

  describe "About page" do
    before { visit about_path }

    it { should have_content('サイト概要') }
    it { should have_title(full_title('サイト概要')) }
  end

  it "should have the right links on the layout" do
    visit root_path
    click_link "サイト"
    expect(page).to have_title(full_title('サイト'))
    #click_link "ヘルプ"
    #expect(page).to have_title(full_title('ヘルプ'))
    #click_link "ホーム"
    #click_link "サインインしてください!"
    #expect(page).to have_title(full_title('サインイン'))
  #  click_link "Documents"
  #  expect(page).to have_title(full_title('All documents'))
    #click_link "kame docs"
    #expect(page).to # ここにコードを記入
  end  
end
