# encoding: utf-8

require 'spec_helper'

describe "Authentication" do

  subject { page }

  describe "signin page" do
    before { visit signin_path }

    it { should have_content('サインイン') }
    it { should have_title('サインイン') }
  end

  describe "signin" do
    before { visit signin_path }

    describe "with invalid information" do
      before { click_button "サインイン" }

      it { should have_title('サインイン') }
      it { should have_selector('div.alert.alert-error', text: 'Name') }

      #describe "after visiting another page" do
      #  before { click_link "ホーム" }
      #  it { should_not have_selector('div.alert.alert-error') }
      #end
    end

    describe "with valid information" do
      let(:admin) { FactoryGirl.create(:admin) }
      before { sign_in admin }

#      it { should have_title(admin.name) }
      it { should have_title(full_title('')) }
      it { should_not have_title('| ホーム') }
#      it { should have_link('アルバム',       href: album_path) }
#      it { should have_link('写真',           href: picture_path) }
      it { should have_link('プロフィール',   href: user_path(admin)) }
#      it { should have_link('編集',           href: edit_user_path(admin)) }
      it { should have_link('全名簿',           href: users_path) }
      it { should have_link('名簿追加',       href: new_user_path) }
      it { should have_link('サインアウト',   href: signout_path) }
      it { should_not have_link('サインイン', href: signin_path) }

      describe "followed by signout" do
        before { click_link "サインアウト" }
        it { should have_link('サインイン') }
      end
    end

  end

  describe "authorization" do

    describe "for non-signed-in users" do
      let(:user) { FactoryGirl.create(:user) }

      describe "when attempting to visit a protected page" do
        before do
          visit edit_user_path(user)
          fill_in "Name",     with: user.name
          fill_in "Password", with: user.password
          click_button "サインイン"
        end

        describe "after signing in" do

          it "should render the desired protected page" do
            expect(page).to have_title('編集')
          end

          describe "when signing in again" do
            before do
              delete signout_path
              visit signin_path
              fill_in "Name",     with: user.name
              fill_in "Password", with: user.password
              click_button "サインイン"
            end

            it "should render the default Home page" do
              expect(page).to have_title(full_title(''))
            end
          end
        end
      end
      
      describe "in the Users controller" do

        describe "visiting the edit page" do
          before { visit edit_user_path(user) }
          it { should have_title('サインイン') }
        end

        describe "submitting to the update action" do
          before { patch user_path(user) }
          specify { expect(response).to redirect_to(signin_path) }
        end

        describe "visiting the user index" do
          before { visit users_path }
          it { should have_title('サインイン') }
        end
      end
    end

    describe "as wrong user" do
      let(:user) { FactoryGirl.create(:user) }
      let(:wrong_user) { FactoryGirl.create(:user, name: "wrong name") }
      before { sign_in user, no_capybara: true }

      describe "submitting a GET request to the Users#edit action" do
        before { get edit_user_path(wrong_user) }
        specify { expect(response.body).not_to match(full_title('Edit user')) }
        specify { expect(response).to redirect_to(root_url) }
      end

      describe "submitting a PATCH request to the Users#update action" do
        before { patch user_path(wrong_user) }
        specify { expect(response).to redirect_to(root_path) }
      end
    end

    describe "as non-admin user" do
      let(:user) { FactoryGirl.create(:user) }
      let(:non_admin) { FactoryGirl.create(:user) }

      before { sign_in non_admin, no_capybara: true }

      describe "submitting a DELETE request to the Users#destroy action" do
        before { delete user_path(user) }
        specify { expect(response).to redirect_to(root_path) }
      end
    end
  end
end
