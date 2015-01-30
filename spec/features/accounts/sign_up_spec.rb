require "rails_helper"

feature "Accounts" do
  scenario "creating an account" do
    visit subscribem.root_path
    click_link "Account Sign Up"
    fill_in "Name", :with => "Test"
    fill_in "Subdomain", :with => "mything"
    fill_in "Email", :with => "test@example.com"
    fill_in "Password", :with => "password", :exact => true
    fill_in "Password confirmation", :with => "password", :exact => true
    click_button "Create Account"

    success_msg = "Your account has been successfully created."
    expect(page).to have_content(success_msg)

    owner_msg = "Signed in as test@example.com"
    expect(page).to have_content(owner_msg)

    expect(page.current_url).to eq('http://mything.example.com/')
  end

  scenario "ensure subdomain uniqueness" do
    Subscribem::Account.create!(:subdomain => 'first', :name => 'First Account')

    visit subscribem.root_path
    click_link "Account Sign Up"
    fill_in "Name", :with => "Some Acct"
    fill_in "Subdomain", :with => "first"
    fill_in "Email", :with => "test@example.com"
    fill_in "Password", :with => "password", :exact => true
    fill_in "Password confirmation", :with => "password", :exact => true
    click_button "Create Account"

    expect(page.current_url).to eq('http://www.example.com/accounts')
    expect(page).to have_content("Sorry, your account could not be created.")
    expect(page).to have_content("Subdomain has already been taken")
  end

  scenario "subdomain with restricted name" do
    visit subscribem.root_path
    click_link "Account Sign Up"
    fill_in "Name", :with => "Some Acct"
    fill_in "Subdomain", :with => "ADMIN"
    fill_in "Email", :with => "test@example.com"
    fill_in "Password", :with => "password", :exact => true
    fill_in "Password confirmation", :with => "password", :exact => true
    click_button "Create Account"

    expect(page.current_url).to eq('http://www.example.com/accounts')
    expect(page).to have_content("Sorry, your account could not be created.")
    expect(page).to have_content("Subdomain is not allowed.")
  end

  scenario "subdomain with invalid characters" do
    visit subscribem.root_path
    click_link "Account Sign Up"
    fill_in "Name", :with => "Some Acct"
    fill_in "Subdomain", :with => "<admin>"
    fill_in "Email", :with => "test@example.com"
    fill_in "Password", :with => "password", :exact => true
    fill_in "Password confirmation", :with => "password", :exact => true
    click_button "Create Account"

    expect(page.current_url).to eq('http://www.example.com/accounts')
    expect(page).to have_content("Sorry, your account could not be created.")
    expect(page).to have_content("Subdomain is not allowed.")
  end
end
