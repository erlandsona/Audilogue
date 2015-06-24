RSpec.describe Sound, type: :model do
  it { should belong_to :creator }

  it { should validate_presence_of :creator }
  it { should validate_presence_of :title }
  it { should validate_presence_of :file }

  it "should have a working factory" do
    Fabricate.build(:sound).should be_valid
  end
end
