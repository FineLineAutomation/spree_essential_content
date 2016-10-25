require "spec_helper"

feature "Pages", js: true do
  given!(:user) { create(:user) }
  stub_authorization!

  scenario "User can view a page" do
    given_i_sign_in
    and_i_have_pages
    when_i_visit_admin_pages
    then_i_should_see_my_pages
  end

  scenario "User can create a page" do
    given_i_sign_in
    when_i_visit_admin_pages
    and_i_create_a_page
    then_i_should_see_it_in_the_list
  end

  scenario "User can edit a page" do
    given_i_sign_in
    and_i_have_pages
    when_i_visit_admin_pages
    and_i_edit_a_page
    then_i_should_see_it_update_in_the_list
  end

  scenario "User can delete a page" do
    given_i_sign_in
    and_i_have_pages
    when_i_visit_admin_pages
    and_i_delete_a_page
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

  def and_i_have_pages
    @page_a = FactoryGirl.create(:page)
    @page_b = FactoryGirl.create(:page)
  end

  def when_i_visit_admin_pages
    find('.sidebar-content-menu a').click
    find('.pages-link a').click
    expect(page).to have_current_path(spree.admin_pages_path)
  end

  def and_i_create_a_page
    click_link "New Page", match: :first

    fill_in "Title", with: "Test Page"
    click_button "Create"
  end

  def and_i_edit_a_page
    within "#spree_page_#{@page_a.id}" do
      find("a.action-edit").click
    end

    @old_title = @page_a.title
    fill_in "Title", with: "Test Editing"
    click_button "Update"
  end

  def and_i_delete_a_page
    @old_title = @page_a.title
    within "#spree_page_#{@page_a.id}" do
      find("a.delete-resource").click
    end
    wait = Selenium::WebDriver::Wait.new ignore: Selenium::WebDriver::Error::NoAlertPresentError
    alert = wait.until { page.driver.browser.switch_to.alert }
    alert.accept
  end

  def then_i_should_see_my_pages
    expect(page).to have_content(@page_a.title)
    expect(page).to have_content(@page_b.title)
  end

  def then_i_should_see_it_in_the_list
    expect(page).to have_current_path(spree.admin_pages_path)
    expect(page).to have_content("Page \"Test Page\" has been successfully created!")
    expect(page).to have_content("Test Page")
    expect(page).to have_selector('td', text: /Test Page/i)
  end

  def then_i_should_see_it_update_in_the_list
    expect(page).to have_current_path(spree.admin_pages_path)
    expect(page).to have_content("Page \"Test Editing\" has been successfully updated!")
    expect(page).to have_content("Test Editing")
    expect(page).to_not have_selector('td', text: /#{@old_title}/i)
  end

  def then_i_should_see_it_removed_in_the_list
    expect(page).to have_current_path(spree.admin_pages_path)
    expect(page).to have_content("Page \"#{@old_title}\" has been successfully removed!")
    expect(page).to_not have_selector('td', text: /#{@old_title}/i)
  end
end