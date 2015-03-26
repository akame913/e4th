# encoding: utf-8
require 'spec_helper'

describe "Image Pages" do
  subject { page }

  describe "index" do
    let(:user) { FactoryGirl.create(:user) }
    before do
      sign_in user
      visit pictures_path
    end

    it { should have_title('投稿写真') }
    it { should have_content('投稿写真') }

    describe "pagination" do

      before(:all) { 10.times { FactoryGirl.create(:image) } }
      after(:all)  { Image.delete_all }

      #it { should have_selector('div.pagination') }

      it "should list each image" do
        Image.paginate(page: 1).each do |image|
          #expect(page).to have_selector('section', text: image.name)
        end
      end
    end
  end
end
