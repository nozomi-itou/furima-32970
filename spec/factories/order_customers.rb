FactoryBot.define do
  factory :order_customer do
    post_code_id { '123-4567' }
    area_id { 2 }
    city { '練馬区' }
    address { '1-1' }
    building_name { '東京ハイツ' }
    phone_number { '09012345678' }

    token {"tok_abcdefghijk00000000000000000"}
  end
end
