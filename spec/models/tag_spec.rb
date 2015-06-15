require 'rails_helper'

RSpec.describe Tag, type: :model do

  it { should have_many(:posts).through(:taggings) }
  it { should have_many(:taggings) }
  it { should validate_presence_of(:name) }
  it { should validate_length_of(:name).is_at_least(2) }
  it { should_not allow_value('asdlfkj lkj asdf', 'asldfkj*@#$()asd;lkj', 'bob@example.com', '!@#$%^&*()<>?,./{}|[]:;\'\"+=\ ').for(:name) }


end
