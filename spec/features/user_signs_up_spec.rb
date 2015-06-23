feature "User Signs Up" do

  background do
    visit root_path
    within "nav" do
      click_on "Sign Up"
    end
  end


  scenario "Happy Path" do
    user = Fabricate.build(:user)
    fill_in "First Name", with: user.first_name
    fill_in "Last Name", with: user.last_name
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    fill_in "Password Confirmation", with: user.password
    within "form" do
      click_button "Sign Up"
    end
    page.should have_content("Welcome! You have signed up successfully.")
    page.should_not have_link("Sign Up")
    current_path.should == root_path
    click_on "Sign Out"
    click_on "Sign In"
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    within "form" do
      click_button "Sign In"
    end
    page.should have_content("Signed in successfully.")
  end

  scenario "Error Path fill in with blanks" do
    user = Fabricate.build(:user)
    fill_in "First Name", with: ""
    fill_in "Last Name", with: ""
    fill_in "Email", with: ""
    fill_in "Password", with: ""
    fill_in "Password Confirmation", with: ""
    within "form" do
      click_button "Sign Up"
    end
    page.should have_content("Please review the problems below:")

    page.should have_error("can't be blank", on: "First Name")
    page.should have_error("can't be blank", on: "Last Name")
    page.should have_error("can't be blank", on: "Email")
    page.should have_error("can't be blank", on: "Password")

    fill_in "First Name", with: user.first_name
    fill_in "Last Name", with: user.last_name
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    fill_in "Password Confirmation", with: user.password
    within "form" do
      click_on "Sign Up"
    end
    page.should have_content("Welcome! You have signed up successfully.")
  end

  scenario "Error Path fill in with invalid information" do
    user = Fabricate.build(:user)
    fill_in "First Name", with: "!#$%LJASDFK"
    fill_in "Last Name", with: "!#$%LJASDFK"
    fill_in "Email", with: "joeexample.com"
    fill_in "Password", with: "as"
    fill_in "Password Confirmation", with: ""
    within "form" do
      click_on "Sign Up"
    end
    page.should have_content("Please review the problems below:")

    page.should have_error("invalid format", on: "Email")
    page.should have_error("is too short (minimum is 8 characters)", on: "Password")
    page.should have_error("doesn't match Password", on: "Password Confirmation")

    fill_in "First Name", with: user.first_name
    fill_in "Last Name", with: user.last_name
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    fill_in "Password Confirmation", with: user.password
    within "form" do
      click_on "Sign Up"
    end
    page.should have_content("Welcome! You have signed up successfully.")
  end

  scenario "Error Path fill in with not unique email" do
    Fabricate(:user, email: "austin@erlandson.com")
    user = Fabricate.build(:user, email: "austin@erlandson.com")
    fill_in "First Name", with: user.first_name
    fill_in "Last Name", with: user.last_name
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    fill_in "Password Confirmation", with: user.password
    within "form" do
      click_on "Sign Up"
    end
    page.should have_content("Please review the problems below:")

    page.should have_error("has already been taken", on: "Email")

    fill_in "First Name", with: user.first_name
    fill_in "Last Name", with: user.last_name
    fill_in "Email", with: "bob@example.com"
    fill_in "Password", with: user.password
    fill_in "Password Confirmation", with: user.password
    within "form" do
      click_on "Sign Up"
    end
    page.should have_content("Welcome! You have signed up successfully.")
  end

end
