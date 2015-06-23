# feature "User edits posts" do

#   let!(:user){ Fabricate(:user) }
#   let!(:foo_post){ Fabricate(:post, author: user, title: "Foo", body: "Bar") }
#   let!(:other_user){ Fabricate(:user) }

#   background do
#     pending
#   end

#   scenario "logged out user can't edit" do
#     visit user_post_path(user, foo_post)
#     page.should_not have_link(href: edit_user_post_path(user, foo_post))
#     visit edit_user_post_path(user, foo_post)
#     should_be_denied_access
#   end

#   scenario "other user can't edit" do
#     signin_as other_user
#     visit user_post_path(user, foo_post)
#     page.should_not have_link(href: edit_user_post_path(user, foo_post))
#     visit edit_user_post_path(user, foo_post)
#     should_be_denied_access
#   end

#   scenario "happy path edit" do
#     signin_as user
#     visit user_post_path(user, foo_post)
#     click_on "Edit Post"
#     fill_in "Title", with: "Food"
#     fill_in "Body", with: "At a bar-b-que"
#     click_on "Publish Updates"
#     page.should have_content("Your updates have been published.")
#     current_path.should == user_post_path(user, foo_post)
#     page.should have_content("Food")
#     page.should have_content("At a bar-b-que")
#   end

#   scenario "sad path preserves edits" do
#     signin_as user
#     visit user_post_path(user, foo_post)
#     click_on "Edit Post"
#     fill_in "Title", with: "Food"
#     fill_in "Body", with: ""
#     click_on "Publish Updates"
#     page.should have_content("Your updates could not be published. Please correct the errors below.")
#     field_labeled("Title").value.should == "Food"
#     field_labeled("Body").value.should == ""
#     page.should have_error("can't be blank", on: "Body")
#   end
# end
