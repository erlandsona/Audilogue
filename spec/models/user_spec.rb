RSpec.describe User, type: :model do
  describe "validations" do
    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:last_name) }
    it "should allow valid values for email" do
      should allow_value("eliza@elizamarcum.com", "a@b.co.uk", "eliza+hash@example.com").for(:email)
    end
    describe "should be invalid if email is not formatted correctly" do
      it { should_not allow_value("elizabrock.com").for(:email) }
      it { should_not allow_value("eliza@examplecom").for(:email) }
      it { should_not allow_value("@.com").for(:email) }
    end
    it "should have a working factory" do
      Fabricate.build(:user).should be_valid
    end
  end
end
