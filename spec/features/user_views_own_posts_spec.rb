# feature "User views own posts" do

#   let(:julie){ Fabricate(:user, name: "Julie") }

#   background do
#     Fabricate(:post, author: julie, title: "Julie's Intro to XPath", body: "XPath is *great*")
#     Fabricate(:post, author: julie, title: "Julie's Over XPath", body: "XPath is *great*")
#     Fabricate(:draft, author: julie, title: "Unfinished Post")
#     visit root_path
#   end

#   scenario "viewing your own blog posts" do
#     user = julie
#     visit "/"
#     click_on "Sign In"
#     fill_in "Email", with: user.email
#     fill_in "Password", with: "password1"
#     click_button "Sign In"
#     page.should have_content("Welcome back, Julie")
#     click_on "Julie's Knowledge"
#     page.should have_link("Julie's Intro to XPath")
#     page.should have_link("Julie's Over XPath")
#     page.should_not have_content("Bob's Burger Recipe")
#     page.should have_link("All Contributors", href: root_path)
#     page.should have_content("Unfinished Post [DRAFT]")
#   end
# end
