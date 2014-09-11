FactoryGirl.define do
  factory :user do
    name "Jordan"
    email "nemrowj@gmizzail.com"
    password "password"
  end

  factory :vendor_credential do
    username "email_from_nords@yahoo.com"
    password "passwordd"
  end
end
