FactoryGirl.define do
  factory :account, :class => 'Subscribem::Account' do
    sequence(:name) { |n| "Test Account ##{n}" }
    sequence(:subdomain) { |n| "test#{n}" }
    association :owner, :factory => :user
  end

    factory :user, :class => 'Subscribem::User' do
    sequence(:email) { |n| "test#{n}@example.com" }
    password "password"
    password_confirmation "password"
  end

end
