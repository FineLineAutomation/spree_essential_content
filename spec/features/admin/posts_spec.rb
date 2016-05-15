require "spec_helper"

feature "Blog Posts", js: true do
  given!(:user) { create(:user) }
  stub_authorization!

  scenario "User can view a blog post" do
    given_i_sign_in
    and_i_have_posts
    when_i_visit_admin_posts
    then_i_should_see_my_posts
  end

  scenario "User can create a blog post" do
    given_i_sign_in
    when_i_visit_admin_posts
    and_i_create_a_post
    then_i_should_see_it_in_the_list
  end

  scenario "User can edit a blog post" do
    given_i_sign_in
    and_i_have_posts
    when_i_visit_admin_posts
    and_i_edit_a_post
    then_i_should_see_it_update_in_the_list
  end

  scenario "User can delete a blog post" do
    given_i_sign_in
    and_i_have_posts
    when_i_visit_admin_posts
    and_i_delete_a_post
    then_i_should_see_it_removed_in_the_list
  end

  def given_i_sign_in
    visit spree.login_path
    within '#new_spree_user' do
      fill_in 'Email', with: user.email
      fill_in 'Password', with: user.password
    end
    click_button 'Login'
    visit "/admin"
    expect(page).to have_current_path(spree.admin_orders_path)
  end

  def and_i_have_posts
    @post_a = FactoryGirl.create(:post)
    @post_b = FactoryGirl.create(:post)
  end

  def when_i_visit_admin_posts
    find('.contents-nav').find('a').click
    expect(page).to have_current_path(spree.admin_pages_path)
    click_link 'Blog Posts'
    expect(page).to have_current_path(spree.admin_posts_path)
  end

  def and_i_create_a_post
    @blog = FactoryGirl.create(:blog)
    click_link "New Post", match: :first

    select @blog.name, from: "post_blog_id"
    fill_in "Post Title", with: "Test Post"
    fill_in "Teaser Line", with: "Awesome test post"
    fill_in "Post Content", with: "This is my awesome test blog post!"
    click_button "Create"
  end

  def and_i_edit_a_post
    within "#post_#{@post_a.id}" do
      find("a.edit").click
    end

    @old_title = @post_a.title
    fill_in "Post Title", with: "Test Editing"
    click_button "Update"
  end

  def and_i_delete_a_post
    @old_title = @post_a.title
    within "#post_#{@post_a.id}" do
      find("a.delete-resource").click
    end
    wait = Selenium::WebDriver::Wait.new ignore: Selenium::WebDriver::Error::NoAlertPresentError
    alert = wait.until { page.driver.browser.switch_to.alert }
    alert.accept
  end

  def then_i_should_see_my_posts
    expect(page).to have_content(@post_a.title)
    expect(page).to have_content(@post_b.title)
  end

  def then_i_should_see_it_in_the_list
    expect(page).to have_current_path(spree.admin_posts_path)
    expect(page).to have_content("Post \"Test Post\" has been successfully created!")
    expect(page).to have_selector('td', text: /Test Post/i)
  end

  def then_i_should_see_it_update_in_the_list
    expect(page).to have_current_path(spree.admin_posts_path)
    expect(page).to have_content("Post \"Test Editing\" has been successfully updated!")
    expect(page).to have_content("Test Editing")
    expect(page).to_not have_selector('td', text: /#{@old_title}/i)
  end

  def then_i_should_see_it_removed_in_the_list
    expect(page).to have_current_path(spree.admin_posts_path)
    expect(page).to have_content("Post \"#{@old_title}\" has been successfully removed!")
    expect(page).to_not have_selector('td', text: /#{@old_title}/i)
  end
end