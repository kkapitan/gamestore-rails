FactoryGirl.define do
  factory :review do
    title { FFaker::Lorem::sentence(3) }
    body { FFaker::Lorem::paragraph(2) }
    mark { rand(11) }

    association :user
    association :game

  end
end
