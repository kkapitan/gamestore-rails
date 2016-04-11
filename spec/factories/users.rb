FactoryGirl.define do
  factory :user do
    email { FFaker::Internet.email }
    password "password"
    password_confirmation "password"
    name { FFaker::Name.first_name }
    last_name { FFaker::Name.last_name }
    nickname { FFaker::Lorem.word }
    factory :user_with_game_library do
      after(:create) do |user|
        create_list(:library, 3, user: user )
      end
    end
  end
end
