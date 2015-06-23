feature "User edits profile" do

  let(:luke){ Fabricate(:user, name: "Luke", email: "a@b.com") }
  let(:allison){ Fabricate(:user, name: "Allison") }

  scenario "logged out user can't edit profile" do
    visit user_posts_path(luke)
    page.should_not have_link("Edit")
    visit "/user/edit"
    current_path.should == root_path
  end

  scenario "different user can't edit profile" do
    visit "/"
    click_on "Sign In"
    fill_in "Email", with: luke.email
    fill_in "Password", with: "password1"
    click_button "Sign In"
    visit user_posts_path(allison)
  end

  scenario "user edit profile happy path" do
    visit "/"
    click_on "Sign In"
    fill_in "Email", with: luke.email
    fill_in "Password", with: "password1"
    click_button "Sign In"
    click_on "Luke"
    visit edit_user_path
    current_path.should == edit_user_path
    field_labeled("Name").value.should == "Luke"
    field_labeled("Bio").value.should == luke.bio
    field_labeled("Email").value.should == "a@b.com"
    fill_in "Name", with: "LANCASTER"
    fill_in "Bio", with: "He's just this guy, you know?"
    fill_in "Email", with: "zaphod@beeblebrox.new"
    click_on "Save Changes"
    page.should have_css(".flash-notice", text: "Your profile has been updated")
    page.should have_content("LANCASTER")
    page.should have_css(".gravatar")
    page.should have_content("He's just this guy, you know?")
    page.should have_link("Edit")
  end

  scenario "edit user profile sad path" do
    visit "/"
    click_on "Sign In"
    fill_in "Email", with: luke.email
    fill_in "Password", with: "password1"
    click_button "Sign In"
    click_on "Luke"
    click_on "Edit"
    fill_in "Name", with: "LANCASTER"
    fill_in "Bio", with: "He's just this guy, you know?"
    fill_in "Email", with: ""
    click_on "Save Changes"
    page.should have_css(".flash-alert", text: "Please fix the errors below to continue")
    field_labeled("Name").value.should == "LANCASTER"
    field_labeled("Bio").value.should == "He's just this guy, you know?"
    field_labeled("Email").value.should == ""
    page.should have_css(".email .error", text: "can't be blank")
  end
end
