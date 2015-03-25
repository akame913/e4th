require 'spec_helper'

describe ImagesController do

  describe "GET 'new--no-test-framework'" do
    it "returns http success" do
      get 'new--no-test-framework'
      response.should be_success
    end
  end

end
