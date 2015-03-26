# encoding: utf-8

require 'spec_helper'

describe Image do
  let(:article) { FactoryGirl.create(:article) }
  before do
    #@picture = Picture.new(article_id: article.id , image_file_name: "picture.png" ,
    #                 image_content_type: "image/png" )
    @image = article.images.build(name: "picture.png" ,
                                  content_type: "image/png")
  end

  subject { @image }

  it { should respond_to(:article_id) }
  it { should respond_to(:name) }
  it { should respond_to(:content_type) }  

  describe "when article_id is not present" do
    before { @image.article_id = nil }
    it { should_not be_valid }
  end
end
