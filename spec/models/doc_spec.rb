# encoding: utf-8

require 'spec_helper'

describe Doc do

  let(:user) { FactoryGirl.create(:user) }

  before do
    #@doc = Doc.new(name: "Example Document", description: "yyyy",
    #                 data: "this is data", content_type: "text.abc.txt" )
    @doc = user.docs.build(name: "Example Document", 
                           group_id: 1,
                           description: "Descript",
                           name:  "doc Name",
                           doc_data: "this is data", 
                           doc_type: "text.abc.txt" )
  end

  subject { @doc }

  it { should respond_to(:name) }
  it { should respond_to(:group_id) }
  it { should respond_to(:user_id) }
  it { should respond_to(:description) }
  it { should respond_to(:name) }  
  it { should respond_to(:doc_data) }  
  it { should respond_to(:doc_type) }  
  it { should respond_to(:user_id) }
  its(:user) { should eq user }
  
  it { should be_valid }

  describe "when group_id is not present" do
    before { @doc.group_id = nil }
    it { should_not be_valid }
  end

  describe "when user_id is not present" do
    before { @doc.user_id = nil }
    it { should_not be_valid }
  end

  describe "when name is not present" do
    before { @doc.name = " " }
    it { should_not be_valid }
  end

  describe "when description is not present" do
    before { @doc.description = " " }
    it { should_not be_valid }
  end

end
