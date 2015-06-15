require 'rails_helper'
feature "User views posts" do

  let(:julie){ Fabricate(:user, name: "Julie") }

  background do
    bob = Fabricate(:user, name: "Bob")
    ingrid = Fabricate(:user, name: "Ingrid")
    Fabricate(:post, author: bob, title: "Bob's Burger Recipe")
    Fabricate(:post, author: julie, title: "Julie's Intro to XPath", body: "XPath is *great*")
    Fabricate(:post, author: julie, title: "Julie's Over XPath", body: "XPath is *great*")
    visit root_path
  end

  scenario "viewing the list of blogs" do
    page.should have_content("Our Knowledgeable Contributors")
    page.should have_link("Bob's Knowledge")
    page.should have_link("Ingrid's Knowledge")
    page.should have_link("Julie's Knowledge")
  end

  scenario "viewing the blog of a particular author" do
    click_on "Julie's Knowledge"
    page.should have_link("Julie's Intro to XPath")
    page.should have_link("Julie's Over XPath")
    page.should_not have_content("Bob's Burger Recipe")
    page.should have_link("All Contributors", href: root_path)
  end

  scenario "viewing an individual post, rendered in markdown" do
    click_on "Julie's Knowledge"
    click_on("Julie's Intro to XPath")
    page.should have_css("h1", text: "Julie's Intro to XPath")
    page.should have_content("XPath is great")
    page.should have_css("em", text: "great")
    page.should have_css(".author", text: "Julie")
    page.should have_link("Return to Julie's Knowledge", href: user_posts_path(julie))
  end
end
