require 'rails_helper'

RSpec.feature "Timeline", type: :feature do
  fixtures :users, :posts
  let(:user) { users(:cynthia) }
  let(:post) { user.posts.build(body: "Hello this is my first post") }

  background do
    visit login_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: "password"
    click_button "Log in"
  end
  
  scenario "Can submit posts and view them" do
    visit "/"
    fill_in "post[message]", with: "Hello, world!"
    
    click_button "Create new post"
    expect(page).to have_content("Hello, world!")
  end

  # This should be refactored into a likes feature. 
  scenario "Can submit a post and like it, and see increased number of likes" do
    visit "/"
    fill_in "post[message]", with: "Hello, world!"

    click_button "Create new post"
    save_and_open_page
    click_button("Like", match: :first)
    expect(page).to have_content("1 like")
    # This should be a second test.
    # click_link("Like", match: :first)
    # expect(page).to have_content("2 likes")
  end

  scenario "Can edit posts" do
    visit "/"
    fill_in "post[message]", with: "Hello, world!"
    click_button "Create new post"
    click_link("Edit", match: :first)
    fill_in "post[message]", with: "Hello, Earth!"
    click_button "Create new post"
    expect(page).to have_content("Hello, Earth!")
  end

  scenario "Can delete posts" do
    visit "/"
    fill_in "post[message]", with: "Hello, world!"
    click_button "Create new post"
    save_and_open_page
    click_link("Delete", match: :first)
    expect(page).not_to have_content("Hello, world!")
  end
 # nope!
  # scenario "cannot submit blank post" do
  #   visit "/posts/new"
  #   fill_in "post[message]", with: ""
  #   click_button "Create new post"
  #   expect(page).to have_current_path "/posts/new"
  # end

  xscenario " Can add comment" do
    visit "/posts/new"
    fill_in "post[message]", with: "Hello, world!"
    click_button "Create new post"
    click_button "Comment"
    fill_in "Comment message", with: "Hello, comment!"
    click_link "Submit"
    expect(page).to have_content("Hello, comment!")
  end

end
