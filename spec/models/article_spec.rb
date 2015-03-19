# encoding: utf-8

require 'spec_helper'

describe Article do
  before { @article = Article.new(title: "Example Article", 
                                   group_id: 1, 
                                   user_id: 1, 
                                   date: "20150315",
                                   content: "Sample content 123456") }

  subject { @article }

  it { should respond_to(:title) }
  it { should respond_to(:group_id) }
  it { should respond_to(:user_id) }
  it { should respond_to(:date) }
  it { should respond_to(:content) }

  it { should be_valid }

  describe "when title is not present" do
    before { @article.title = " " }
    it { should_not be_valid }
  end
  
  describe "picture associations" do
    before { @article.save }
    let!(:older_picture) do
      FactoryGirl.create(:picture, article: @article, created_at: 1.day.ago)
    end
    let!(:newer_picture) do
      FactoryGirl.create(:picture, article: @article, created_at: 1.hour.ago)
    end

    it "should have the right pictures in the right order" do
      expect(@article.pictures.to_a).to eq [newer_picture, older_picture]
    end
  end
end
