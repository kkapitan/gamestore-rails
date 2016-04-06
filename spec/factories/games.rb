FactoryGirl.define do
  factory :game do
    title { FFaker::Product.product_name }
    description { FFaker::Lorem.paragraph(3) }
    price { "100.0" }
  end
end
