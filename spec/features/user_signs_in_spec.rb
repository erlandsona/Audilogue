feature "User signs in" do

  before do
    visit root_path
    within "nav" do
      click_on "Sign In"
    end
  end

  scenario "Returning customer signs in" do
    user = Fabricate(:user)
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Sign In"
    page.should have_content("Signed in successfully.")
    page.should_not have_content("Sign In")
    page.should_not have_content("Sign Up")
    page.should have_content("Sign Out")
    # Smoke testing Sign Out:
    click_on "Sign Out"
    page.should have_content("Signed out successfully.")
    page.should have_content("Sign In")
    page.should_not have_content("Sign Out")
  end

  scenario "Returning user attempts signin with incorrect password" do
    user = Fabricate(:user)
    page.should have_link("Sign Up")
    page.should have_content("Forgot your password?")
    fill_in "Email", with: user.email
    fill_in "Password", with: "WrOngpAssWOrd"
    click_button "Sign In"
    page.should have_content("Invalid email or password.")
    page.should_not have_content("Create your account")
    page.should_not have_content("Password confirmation")
    field_labeled("Email").value.should == user.email
    fill_in "Password", with: user.password
    click_button "Sign In"
    page.should have_content("Signed in successfully.")
  end

  scenario "User signs in with wrong email" do
    Fabricate(:user, email: "susie@example.com", password: "ThisIsAwesome", password_confirmation: "ThisIsAwesome")
    fill_in "Email", with: "joe@example.com"
    fill_in("Password", with: "ThisIsAwesome")
    within "form" do
      click_on "Sign In"
    end
    page.should have_content("Invalid email or password.")
  end

  scenario "User signs in with blanks" do
    within "form" do
      click_on "Sign In"
    end
    page.should have_content("Invalid email or password.")
  end
end
