require 'rails_helper'

feature "User sign in" do
  extend SubdomainHelpers
  # Not sure why I need to explicitly tell FactoryGirl to register the definitions in spec/factories
  FactoryGirl.find_definitions

  let!(:account) { FactoryGirl.create(:account) }
  let(:subdomain_root_url) { "http://#{account.subdomain}.example.com/" }
  let(:sign_in_url) { "#{subdomain_root_url}sign_in" }

  within_account_subdomain do
    scenario "successfully signs in as an account owner" do
      visit subdomain_root_url
      expect(page.current_url).to eq(sign_in_url)
      fill_in "Email", :with => account.owner.email
      fill_in "Password", :with => 'password'
      click_button "Sign In"
      expect(page).to have_content("You are now signed in.")
      expect(page.current_url).to eq(subdomain_root_url)
    end

    scenario "attempts sign in with an invalid password and fails" do
      visit subscribem.root_url(:subdomain => account.subdomain)
      expect(page.current_url).to eq(sign_in_url)
      expect(page).to have_content("Please sign in.")
      fill_in "Email", :with => account.owner.email
      fill_in "Password", :with => "drowssap"
      click_button "Sign In"
      expect(page).to have_content("Invalid email or password.")
      expect(page.current_url).to eq(sign_in_url)
    end

    scenario "attempts sign in with an invalid email and fails" do
      visit subscribem.root_url(:subdomain => account.subdomain)
      expect(page.current_url).to eq(sign_in_url)
      expect(page).to have_content("Please sign in.")
      fill_in "Email", :with => 'someone@elsewhere.com'
      fill_in "Password", :with => "password"
      click_button "Sign In"
      expect(page).to have_content("Invalid email or password.")
      expect(page.current_url).to eq(sign_in_url)
    end

    scenario "cannot sign in if not a part of this subdomain" do
      other_account = FactoryGirl.create(:account)
      visit subscribem.root_url(subdomain: account.subdomain)
      expect(page.current_url).to eq(sign_in_url)
      expect(page).to have_content("Please sign in.")
      fill_in "Email", :with => other_account.owner.email
      fill_in "Password", :with => "password"
      click_button "Sign In"
      expect(page).to have_content("Invalid email or password.")
      expect(page.current_url).to eq(sign_in_url)
    end

  end
end
