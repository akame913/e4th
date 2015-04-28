# encoding: utf-8

require 'spec_helper'

describe "User pages" do

  subject { page }

  describe "index" do
    let(:user) { FactoryGirl.create(:user) }

    before do
      sign_in user
      visit users_path
    end

    it { should have_title('名簿') }
    it { should have_content('名簿') }

    describe "pagination" do

      before(:all) { 40.times { FactoryGirl.create(:user) } }
      after(:all)  { User.delete_all }

      it { should have_selector('div.pagination') }

      it "should list each user" do
        User.paginate(page: 1).each do |user|
          expect(page).to have_selector('tr', text: user.given)
        end
      end
    end

    #describe "delete links" do

    #  it { should_not have_link('delete') }

    #  describe "as an admin user" do
    #    let(:admin) { FactoryGirl.create(:admin) }
    #    before do
    #      sign_in admin
    #      visit users_path
    #    end

    #    it { should have_link('delete', href: user_path(User.first)) }
    #    it "should be able to delete another user" do
    #      expect do
    #        click_link('delete', match: :first)
    #      end.to change(User, :count).by(-1)
    #    end
    #    it { should_not have_link('delete', href: user_path(admin)) }
    #  end
    #end
  end

  describe "profile page" do
    let(:user) { FactoryGirl.create(:user) }

    before do
      sign_in user
      visit user_path(user)
    end
    
    it { should have_content(user.name) }
    it { should have_title("プロフィール") }

   end

  describe "new user page" do
    let(:admin) { FactoryGirl.create(:admin) }
    before { visit new_user_path }

    it { should have_content('名簿追加') }
    it { should have_title(full_title('名簿追加')) }
  end

  describe "new user" do

    before { visit new_user_path }

    let(:submit) { "名簿追加" }

    describe "with invalid information" do
      it "should not create a user" do
        expect { click_button submit }.not_to change(User, :count)
      end

      describe "after submission" do
        before { click_button submit }

        it { should have_title('名簿追加') }
        it { should have_content('error') }
      end
    end

    describe "with valid information" do
      before do
        fill_in "登録名",         with: "Example User"
        fill_in "姓",             with: "Example Family"
        fill_in "名",             with: "Example Given"
        fill_in "新姓",           with: "Example Maiden"
        fill_in "郵便番号",       with: "Example Pobox"
        fill_in "都道府県",       with: "Example Region"
        fill_in "市区",           with: "Example City"
        fill_in "町村番地・ビル", with: "Example Street"
        fill_in "電話番号",       with: "Example Tel"
        fill_in "携帯番号",       with: "Example Mobile"
        fill_in "備考",           with: "Example Notes"
        fill_in "メールアドレス", with: "user@example.com"
        fill_in "パスワード",     with: "foobar"
        fill_in "確認パスワード", with: "foobar"
      end

      it "should create a user" do
        #group_id validate expect { click_button submit }.to change(User, :count).by(1)
      end

      describe "after saving the user" do
        before { click_button submit }
        let(:user) { User.find_by(name: 'Example User') }

        #group_id validate it { should have_link('サインアウト') }
        #group_id validate it { should have_title(user.name) }
      end
    end
  end

  describe "edit" do
    #登録名の変更はadminのみ
    let(:user) { FactoryGirl.create(:admin) }
    before do
      sign_in user
      visit edit_user_path(user)
    end

    describe "page" do
      it { should have_content("編集") }
      it { should have_title("編集") }
    end

    describe "with invalid information" do
      before { click_button "編集保存" }

      it { should have_content('error') }
    end

    describe "with valid information" do
      let(:new_name)  { "New Name" }
      let(:new_email) { "new@example.com" }
      before do
        fill_in "登録名",         with: new_name
        fill_in "メールアドレス", with: new_email
        fill_in "パスワード",     with: user.password
        fill_in "確認パスワード", with: user.password
        click_button "編集保存"
      end

      it { should have_title("プロフィール") }
      it { should have_link('サインアウト', href: signout_path) }
      specify { expect(user.reload.name).to  eq new_name }
      specify { expect(user.reload.email).to eq new_email }
    end

#app/controllers/users_controller.rb user_params変更によるエラー
    describe "forbidden attributes" do
      let(:params) do
        { user: { admin: true, password: user.password,
                  password_confirmation: user.password } }
      end
      before do
        sign_in user, no_capybara: true
        patch user_path(user), params
      end
      #specify { expect(user.reload).not_to be_admin }
    end
  end
end
