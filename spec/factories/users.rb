FactoryGirl.define do
  factory :user do
    email { FFaker::Internet.email }
    password "password"
    password_confirmation "password"

    factory :user_with_game_library do
      after(:create) do |user|
        create_list(:library, 3, user: user )
      end
    end
  end
end
