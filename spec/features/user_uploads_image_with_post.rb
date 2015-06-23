# feature "user creates post" do

#   scenario "and uploads an image" do
#     me = Fabricate(:user, name: "Bob")
#     signin_as me
#     click_on "Share Some Knowledge"
#     fill_in "Title", with: "TIL: Mugs don't wash themselves"
#     fill_in "Body", with: "There are some simple steps to washing a mug.  First, don't set it in the sink.  Then, apply soap, scrub and rinse.  Finally, do set the mug in the drying rack."
#     attach_file("image", Rails.root + 'spec/dummy_data/deadlink.png')
#     click_on "Publish Knowledge"
#     page.should have_notice("Your knowledge has been published")
#     current_path.should == user_posts_path(me)
#     page.should have_link "TIL: Mugs don't wash themselves"
#     click_on "TIL: Mugs don't wash themselves"
#     page.should have_css("p", text: "There are some simple steps to washing a mug. First, don't set it in the sink. Then, apply soap, scrub and rinse. Finally, do set the mug in the drying rack.")
#     page.should have_css(".author", text: "Bob")
#     page.find("header")['style'].should have_content 'deadlink.png'
#   end

#     scenario "and does not upload an image" do
#     me = Fabricate(:user, name: "Bob")
#     signin_as me
#     click_on "Share Some Knowledge"
#     fill_in "Title", with: "TIL: Mugs don't wash themselves"
#     fill_in "Body", with: "There are some simple steps to washing a mug.  First, don't set it in the sink.  Then, apply soap, scrub and rinse.  Finally, do set the mug in the drying rack."
#     click_on "Publish Knowledge"
#     page.should have_notice("Your knowledge has been published")
#     current_path.should == user_posts_path(me)
#     page.should have_link "TIL: Mugs don't wash themselves"
#     click_on "TIL: Mugs don't wash themselves"
#     page.should have_css("p", text: "There are some simple steps to washing a mug. First, don't set it in the sink. Then, apply soap, scrub and rinse. Finally, do set the mug in the drying rack.")
#     page.should have_css(".author", text: "Bob")
#     page.find("header")['style'].should have_content ''
#   end

# end
