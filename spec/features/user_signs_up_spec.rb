require 'rails_helper'

feature "User Signs Up" do

  background do
    visit root_path
    within "nav" do
      click_on "Sign Up"
    end
  end

  scenario "Happy Path" do
    user = Fabricate.build(:user)
    fill_in "First name", with: user.first_name
    fill_in "Last name", with: user.last_name
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    fill_in "Password confirmation", with: user.password
    within "form" do
      click_button "Sign Up"
    end
    page.should have_content("Welcome! You have signed up successfully.")
    click_on "Sign Out"
    click_on "Sign In"
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Sign In"
    page.should have_content("Welcome back, #{user.first_name}")
  end

  scenario "Error Path" do
    user = Fabricate.build(:user)
    fill_in "First name", with: ""
    fill_in "Last name", with: ""
    fill_in "Email", with: "joeexample.com"
    fill_in "Password", with: "password1"
    fill_in "Password confirmation", with: "food"
    click_on "Sign Up"
    page.should have_alert("Please review the problems below:")

    page.should have_error("can't be blank", on: "First name")
    page.should have_error("can't be blank", on: "Last name")
    page.should have_error("is invalid", on: "Email")
    page.should have_error("doesn't match Password", on: "Password confirmation")

    fill_in "Username", with: user.name
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    fill_in "Password confirmation", with: user.password
    click_on "Sign Up"
    page.should have_content("Welcome, #{user.name}")
  end
end
