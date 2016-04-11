FactoryGirl.define do
  factory :game do
    title { FFaker::Product.product_name }
    description { FFaker::Lorem.paragraph(3) }
    price { "100.0" }
    category_cd { :FPS }
    factory :game_with_reviews do
      after(:create) do |game|
        create_list(:review, 3, game: game )
      end
    end

  end
end
