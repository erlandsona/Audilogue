require 'rails_helper'

feature "User Signs Up" do

  background do
    visit root_path
    click_on "Sign Up"
  end

  scenario "Happy Path" do
    user = Fabricate(:user)
    page.should_not have_link("Sign Up")
    fill_in "Username", with: user.name
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    fill_in "Password confirmation", with: user.password
    click_button "Sign Up"
    page.should have_content("Welcome, #{user.name}")
    click_on "Sign Out"
    click_on "Sign In"
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Sign In"
    page.should have_content("Welcome back, #{user.name}")
  end

  scenario "Error Path" do
    user = Fabricate(:user)
    fill_in "Username", with: ""
    fill_in "Email", with: "joeexample.com"
    fill_in "Password", with: "password1"
    fill_in "Password confirmation", with: "food"
    click_on "Sign Up"
    page.should have_alert("Please fix the errors below to continue.")

    page.should have_error("can't be blank", on: "Username")
    page.should have_error("must be an email address", on: "Email")
    page.should have_error("doesn't match Password", on: "Password confirmation")

    fill_in "Username", with: user.name
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    fill_in "Password confirmation", with: user.password
    click_on "Sign Up"
    page.should have_content("Welcome, #{user.name}")
  end
end
