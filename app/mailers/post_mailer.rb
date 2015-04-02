# encoding: utf-8

class PostMailer < ActionMailer::Base
  default from: "akame@gmail.com"

  def post_email(user, post)
    @person = user.name
    @title = post.name
    #mail to: user.email, subject: "記事を投稿しました"
    mail to: "akame913@gmail.com", subject: "news913投稿情報"
  end  
  
end
