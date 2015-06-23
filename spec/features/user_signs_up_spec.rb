feature "User Signs Up" do

  background do
    visit root_path
    click_on "Sign Up"
  end

  scenario "Happy Path With No Bio" do
    page.should_not have_link("Sign Up")
    fill_in "Name", with: "Joe"
    fill_in "Email", with: "joe@example.com"
    fill_in "Username", with: "JoeSchmoe"
    fill_in "Password", with: "password1"
    fill_in "Password confirmation", with: "password1"
    click_button "Sign Up"
    page.should have_content("Welcome, Joe")
    open_last_email
    current_email == "joe@example.com"
    current_email.should have_subject("Welcome to Median")
    current_email.should have_body_text("We hope you're completely average.")
    current_path.should == root_path
    click_on "Sign Out"
    click_on "Sign In"
    fill_in "Email", with: "joe@example.com"
    fill_in "Password", with: "password1"
    click_button "Sign In"
    page.should have_content("Welcome back, Joe")
  end

  scenario "Happy Path With Bio" do
    page.should_not have_link("Sign Up")
    fill_in "Name", with: "Joe"
    fill_in "Email", with: "joe@example.com"
    fill_in "Username", with: "JoeSchmoe"
    fill_in "Password", with: "password1"
    fill_in "Password confirmation", with: "password1"
    fill_in "Bio", with: Faker::Lorem.paragraph
    click_button "Sign Up"
    page.should have_content("Welcome, Joe")
    click_on "Sign Out"
    click_on "Sign In"
    fill_in "Email", with: "joe@example.com"
    fill_in "Password", with: "password1"
    click_button "Sign In"
    page.should have_content("Welcome back, Joe")
  end

  scenario "Error Path" do
    fill_in "Name", with: ""
    fill_in "Email", with: "joeexample.com"
    fill_in "Username", with: ""
    fill_in "Password", with: "password1"
    fill_in "Password confirmation", with: "food"
    click_on "Sign Up"
    page.should have_alert("Please fix the errors below to continue.")

    page.should have_error("can't be blank", on: "Name")
    page.should have_error("must be an email address", on: "Email")
    page.should have_error("can't be blank", on: "Username")
    page.should have_error("doesn't match Password", on: "Password confirmation")

    fill_in "Name", with: "Sally"
    fill_in "Email", with: "joe@example.com"
    fill_in "Username", with: "SallySueMigoo"
    fill_in "Password", with: "password1"
    fill_in "Password confirmation", with: "password1"
    click_on "Sign Up"
    page.should have_content("Welcome, Sally")
  end

  scenario "invalid username" do
    fill_in "Name", with: "Brandon"
    fill_in "Email", with: "joe@example.com"
    fill_in "Username", with: "b rad"
    fill_in "Password", with: "password1"
    fill_in "Password confirmation", with: "password1"
    click_on "Sign Up"
    page.should have_alert("Please fix the errors below to continue.")
    page.should have_error("can't have whitespace or special characters", on: "Username")

    fill_in "Name", with: "Brandon"
    fill_in "Email", with: "joe@example.com"
    fill_in "Username", with: "brad"
    fill_in "Password", with: "password1"
    fill_in "Password confirmation", with: "password1"
    click_on "Sign Up"
    page.should have_content("Welcome, Brandon")
  end
end
