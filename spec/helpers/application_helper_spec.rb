require 'rails_helper'

RSpec.describe ApplicationHelper do
  scenario "full title helper" do
    full_title.should eq("Your Sound In The Cloud")
    full_title("Help").should eq("Help | Your Sound In The Cloud")
  end
end
