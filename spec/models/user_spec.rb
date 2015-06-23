RSpec.describe User, type: :model do
  describe "validations" do
    it { should have_many :sounds }
    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:last_name) }

    it "should allow valid values for email" do
      should allow_value("eliza@elizamarcum.com", "a@b.co.uk", "eliza+hash@example.com").for(:email)
    end

    describe "should not save if username is !unique" do

      it "shoud have error message 'has already been taken' "do
        email = Faker::Internet.email
        Fabricate(:user, email: email)
        user = Fabricate.build(:user, email: email)
        user.valid?.should be_falsey
        (user.errors[:email].any?).should be_truthy
        error = user.errors[:email][0]
        expect(error).to eq('has already been taken')
      end

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
