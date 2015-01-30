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
  end
end
