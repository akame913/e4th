# encoding: utf-8

require 'spec_helper'

describe Picture do
  let(:article) { FactoryGirl.create(:article) }
  before do
    #@picture = Picture.new(article_id: article.id , image_file_name: "picture.png" ,
    #                 image_content_type: "image/png" )
    @picture = article.pictures.build(image_file_name: "picture.png" ,
                                     image_content_type: "image/png")
  end

  subject { @picture }

  it { should respond_to(:article_id) }
  it { should respond_to(:image_file_name) }
  it { should respond_to(:image_content_type) }  
  
  it { should be_valid }

  describe "when article_id is not present" do
    before { @picture.article_id = nil }
    it { should_not be_valid }
  end
end
