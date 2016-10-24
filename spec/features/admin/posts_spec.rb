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

  scenario "User can see images for a blog post" do
    given_i_sign_in
    and_i_have_posts_with_images
    when_i_view_post_images
    then_i_should_see_the_images_for_the_post
  end

  scenario "User can add images to a blog post" do
    given_i_sign_in
    and_i_have_posts
    when_i_add_an_image
    then_i_should_see_the_image_on_my_post
  end

  scenario "User can edit images on a blog post" do
    given_i_sign_in
    and_i_have_posts_with_images
    when_i_edit_an_image
    then_i_should_see_the_updated_image_on_my_post
  end

  scenario "User can delete images on a blog post" do
    given_i_sign_in
    and_i_have_posts_with_images
    when_i_delete_an_image
    then_i_should_see_the_image_removed_from_my_post
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

  def and_i_have_posts_with_images
    and_i_have_posts
    @post_a_image_1 = FactoryGirl.create(:post_image, viewable: @post_a)
    @post_a_image_2 = FactoryGirl.create(:post_image, viewable: @post_a)
    @post_b_image_1 = FactoryGirl.create(:post_image, viewable: @post_b)
  end

  def when_i_visit_admin_posts
    find('.sidebar-content-menu a').click
    find('.blog-posts-link a').click
    expect(page).to have_current_path(spree.admin_posts_path)
  end

  def when_i_view_post_images
    when_i_visit_admin_posts
    within "#post_#{@post_a.id}" do
      find("a.action-edit").click
    end
    find('.post-images').click
    expect(page).to have_current_path(spree.admin_post_images_path(@post_a))
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
      find("a.action-edit").click
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

  def when_i_add_an_image
    when_i_view_post_images
    click_link "New Image"
    attach_file("Attachment", File.expand_path('../../factories/1.jpg', File.dirname(__FILE__)))
    fill_in "post_image_alt", with: "Test Image"
    click_button "Create"
  end

  def when_i_edit_an_image
    when_i_view_post_images
    within "#spree_post_image_#{@post_a_image_1.id}" do
      find("a.action-edit").click
    end

    @old_title = @post_a_image_1.alt
    fill_in "post_image_alt", with: "Test Image Update"
    attach_file("Attachment", File.expand_path('../../factories/1.png', File.dirname(__FILE__)))
    click_button "Update"
  end

  def when_i_delete_an_image
    when_i_view_post_images
    @old_title = @post_a_image_1.alt
    within "#spree_post_image_#{@post_a_image_1.id}" do
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
    expect(page).to have_content("Test Post")
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

  def then_i_should_see_the_images_for_the_post
    expect(page).to have_content(@post_a_image_1.alt)
    expect(page).to have_content(@post_a_image_2.alt)
    expect(page).to_not have_content(@post_b_image_1.alt)
  end

  def then_i_should_see_the_image_on_my_post
    expect(page).to have_current_path(spree.admin_post_images_path(@post_a))
    expect(page).to have_content("Post image has been successfully created!")
    expect(page).to have_selector('td', text: /Test Image/i)
  end

  def then_i_should_see_the_updated_image_on_my_post
    expect(page).to have_current_path(spree.admin_post_images_path(@post_a))
    expect(page).to have_content("Post image has been successfully updated!")
    expect(page).to have_content("Test Image Update")
    expect(page).to_not have_selector('td', text: /#{@old_title}/i)
  end

  def then_i_should_see_the_image_removed_from_my_post
    expect(page).to have_current_path(spree.admin_post_images_path(@post_a))
    expect(page).to have_content("Post image has been successfully removed!")
    expect(page).to_not have_selector('td', text: /#{@old_title}/i)
  end
end