FactoryBot.define do
  factory :buyer_order do
    token       {'tok_abcdefghijk00000000000000000'}
    postal_code {'123-4567'}
    area_id     {1}
    city        {'札幌市'}
    address     {'1-1'}
    building    {'札幌ビル'}
    phone_num   {'09012345678'}
  end
end