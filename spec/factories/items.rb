FactoryBot.define do
  factory :item do
    name        {'item-name'}
    description {'sample text 123'}
    category_id {1}
    status_id   {1}
    burden_id   {1}
    area_id     {1}
    days_id     {1}
    price       {500}
    association :user

    after(:build) do |item|
      item.image.attach(io: File.open('public/images/test_image.jpg'), filename: 'test_image.jpg')
    end
  end
end