require 'rails_helper'

feature "User sign up" do
  extend SubdomainHelpers

  let!(:account) { FactoryGirl.create(:account) }
  let(:subdomain_root_url) { "http://#{account.subdomain}.example.com/" }
  let(:sign_in_url) { "#{subdomain_root_url}sign_in" }

  scenario "successfully signs up as an new user for an account" do
    visit subdomain_root_url
    expect(page.current_url).to eq(sign_in_url)
    click_link "New User?"
    fill_in "Email", :with => "new_user@example.edu"
    fill_in "Password", :with => 'password'
    fill_in "Password confirmation", :with => 'password'
    click_button "Sign up"
    expect(page.current_url).to eq(subdomain_root_url)
    expect(page).to have_content("You have signed up successfully.")
  end
end
