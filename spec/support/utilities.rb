# encoding: utf-8

def full_title(page_title)
  base_title = "同期会"
  if page_title.empty?
    base_title
  else
    "#{base_title} | #{page_title}"
  end
end

def sign_in(user, options={})
  if options[:no_capybara]
    # Capybaraを使用していない場合にもサインインする。
    remember_token = User.new_remember_token
    cookies[:remember_token] = remember_token
    user.update_attribute(:remember_token, User.encrypt(remember_token))
  else
    visit signin_path
    fill_in "Name",    with: user.name
    fill_in "Password", with: user.password
    click_button "サインイン"
  end
end
