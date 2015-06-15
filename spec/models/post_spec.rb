require 'rails_helper'

RSpec.describe Post, type: :model do
  it { should belong_to :author }
  it { should have_many(:tags).through(:taggings) }
  it { should validate_presence_of :body }
  it { should validate_presence_of :title }
  it { should validate_presence_of :author }

  describe "#all_tags" do

    context "happy path" do
      it "should allow values and create tags" do
        post = Fabricate.build(:post)
        post.all_tags = "asdf, lkhh, qwer"
        post.save.should eq(true)
        post.all_tags.should eq("asdf, lkhh, qwer")
      end
    end

    context "sad path" do
      it "should not allow values and create tags" do
        post = Fabricate.build(:post)
        post.all_tags=("a!@\#$sdf 1234 qwer")
        post.save.should eq(false)
        post.errors.messages[:tags].should include("is invalid")
        post.errors.messages[:all_tags].should include("Can't contain special characters")
      end
    end

  end

  it "should have a working factory" do
    Fabricate.build(:post).should be_valid
  end
end

