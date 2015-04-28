# encoding: utf-8

require 'spec_helper'

describe "Doc Pages" do
  subject { page }

  let(:user) { FactoryGirl.create(:admin) }
  before { sign_in user }
  
  describe "new doc" do
    
    before { visit new_doc_path }
    it { should have_title('文書登録') }
    it { should have_content('文書登録') }

    let(:submit) { "文書登録" }

    describe "with invalid information" do
      it "should not create a document" do
        expect { click_button submit }.not_to change(Doc, :count)
      end

      describe "after submission" do
        before { click_button submit }

        it { should have_title('文書登録') }
        it { should have_content('error') }
      end
    end

    describe "with valid information" do
      before do
        fill_in "内容",  with: "Example description"
        attach_file "文書選択", "#{Rails.root}/spec/factories.rb"
      end

      it "should create a document" do
        expect { click_button submit }.to change(Doc, :count).by(1)
      end

      describe "after saving the document" do
        before { click_button submit }
        let(:doc) { Doc.find_by(name: 'factories.rb') }

        it { should have_title(doc.name) }
        it { should have_selector('div.alert.alert-success', 
                                  text: '文書登録されました!') }
      end
    end
  end

  describe "edit" do
    let(:doc) { FactoryGirl.create(:doc, group_id: 1, user: user) }
    let(:submit) { "文書変更" }

    before do
      sign_in user
      visit edit_doc_path(doc)
    end

    describe "page" do
      it { should have_content("文書変更") }
      it { should have_title("文書変更") }
    end

    describe "with invalid information" do
      let(:blank_description)  { " " }
      before do
        fill_in "内容",  with: blank_description
        click_button  submit
      end
      
      it { should have_content('error') }
    end

    describe "with valid information" do
      let(:new_description)  { "New description" }
      before do
        fill_in "内容",  with: new_description
        #attach_file "文書選択", "#{Rails.root}/spec/factories.rb"
        click_button  submit
      end

      it { should have_selector('div.alert.alert-success') }
      specify { expect(doc.reload.description).to  eq new_description }
    end
  end

  describe "index" do
    before do
      visit docs_path
    end

    it { should have_title('文書一覧') }
    it { should have_content('文書一覧') }

    describe "pagination" do

      before(:each) { 10.times { FactoryGirl.create(:doc, group_id: 1, user: user) } }
      after(:each)  { Doc.delete_all }

      #it { should have_selector('div.pagination') }

      it "should list each document" do
        Doc.paginate(page: 1).each do |doc|
          #expect(page).to have_selector('p', text: doc.description)
        end
      end
    end
  end

  describe "show" do
    let(:doc) { FactoryGirl.create(:doc, group_id: 1, user: user) }
    before { visit doc_path(doc) }

    it { should have_content(doc.name) }
    it { should have_title(doc.name) }
  end

end
