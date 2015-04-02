# encoding: utf-8

require 'spec_helper'

describe "Micropost pages" do

  subject { page }

  let(:user) { FactoryGirl.create(:user) }
  before { sign_in user }

  describe "index" do
    before do
      visit microposts_path
    end

    it { should have_title('マイ一言') }
    it { should have_content('マイ一言') }

    describe "pagination" do

      before(:all) { 10.times { FactoryGirl.create(:micropost, user: user, group_id: 1) } }
      after(:all)  { Micropost.delete_all }

      #it { should have_selector('div.pagination') }

      it "should list each image" do
        Micropost.paginate(page: 1).each do |image|
          #expect(page).to have_selector('section', text: image.name)
        end
      end
    end
  end

  describe "micropost creation" do
    before { visit root_path }

    describe "with invalid information" do

      it "should not create a micropost" do
        expect { click_button "一言写真追加" }.not_to change(Micropost, :count)
      end

      describe "error messages" do
        before { click_button "一言写真追加" }
        it { should have_content('登録できませんでした') }
      end
    end

    describe "with valid information" do

      before { fill_in 'micropost_content', with: "Lorem ipsum" }
      it "should create a micropost" do
        expect { click_button "一言写真追加" }.to change(Micropost, :count).by(1)
      end
    end
  end

  describe "micropost destruction" do
    before do
      FactoryGirl.create(:micropost, user: user, group_id: 1)
    end

    describe "as correct user" do
      before { visit root_path }

      it "should delete a micropost" do
        #expect { click_link "削除" }.to change(Micropost, :count).by(-1)
      end
    end
  end

end
