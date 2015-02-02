require 'rails_helper'

RSpec.describe Subscribem::Account, :type => :model do
  it "can be created with an owner" do
    params = {name: "Test Account",
              subdomain: "test",
              owner_attributes: {email: 'user@example.com',
                                 password: 'password',
                                 password_confirmation: 'password'}
             }
    account = Subscribem::Account.create_with_owner(params)
    expect(account.persisted?).to eq(true)
    expect(account.users.first).to eq(account.owner)
  end

  it "can not be created without a subdomain" do
    params = {name: "Test Account",
              owner_attributes: {email: 'user@example.com',
                                 password: 'password',
                                 password_confirmation: 'password'}
             }
    account = Subscribem::Account.create_with_owner(params)
    expect(account.persisted?).to eq(false)
    expect(account.users.empty?).to eq(true)
  end
end
