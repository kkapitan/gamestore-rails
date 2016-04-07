FactoryGirl.define do
  factory :review do
    title { "review" }
    body { "Nice game" }
    mark { rand(11) }

    association :user
    association :game

  end
end
