# feature "user creates comment" do

#   let(:julie){ Fabricate(:user, name: "Julie") }

#   background do
#     bob = Fabricate(:user, name: "Bob")
#     Fabricate(:post, author: bob, title: "Bob's Burger Recipe")
#     visit root_path
#   end



#   # As a comment-poster,
#   # In order to share my comments to the post,
#   # I want to publish a comment
#   # Acceptance Criteria:
#   # * Comment must have a body
#   # * Comment must be publicly visible once saved

#   scenario "logged out users can't create comments" do
#     click_on "Bob's Knowledge"
#     page.should have_content("Bob's Burger Recipe")
#     page.should_not have_content("Leave a comment")
#     click_on "Bob's Burger Recipe"
#   end

#   scenario "happy path" do
#     me = Fabricate(:user, name: "Holly")
#     signin_as me
#     click_on "Bob's Knowledge"
#     page.should have_content("Bob's Burger Recipe")
#     click_on "Bob's Burger Recipe"
#     page.should have_css("h1", text: "Bob's Burger Recipe")
#     fill_in "comment_body", with: "Here's my comment to you, Bob."
#     click_on "Publish Comment"
#     page.should have_notice("Your comment has been published")
#     page.should have_css("a", text: "Holly")
#     page.should have_css(".comment", text: "Here's my comment to you, Bob.")
#    end

#    scenario "sad path" do
#      me = Fabricate(:user, name: "Sally")
#      signin_as me
#      click_on "Bob's Knowledge"
#      page.should have_content("Bob's Burger Recipe")
#      click_on "Bob's Burger Recipe"
#      page.should have_css("h1", text: "Bob's Burger Recipe")
#      fill_in "comment_body", with: ""
#      click_on "Publish Comment"
#      page.should have_alert("Your comment could not be published. Please correct the errors below.")
#      page.should have_error("can't be blank", on: "comment_body")
#      fill_in "comment_body", with: "Here's my comment to you, Bob."
#      click_on "Publish Comment"
#      page.should have_notice("Your comment has been published")
#    end
# end
