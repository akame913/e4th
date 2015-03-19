# encoding: utf-8
require 'spec_helper'

describe "Picture Pages" do
  subject { page }

  let(:user) { FactoryGirl.create(:user) }
  before { sign_in user }

  describe "picture creation" do
    let(:article) { FactoryGirl.create(:article) }
#    before { visit article_path(article) }

    describe "with invalid information" do

      it "should not create a picture" do
#        expect { click_button "写真追加" }.not_to change(Picture, :count)
      end

      describe "error messages" do
#        before { click_button "写真追加" }
#        it { should have_content('error') }
      end
    end
  end
end
