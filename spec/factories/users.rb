FactoryBot.define do
  factory :user do
    nickname              {'test'}
    email                 {'test@example'}
    password              {'000aaa'}
    password_confirmation {password}
    last_name             {'佐藤'}
    first_name            {`三郎`}
    last_name_kana        {'サトウ'}
    first_name_kana       {'サブロウ'}
    birthday              {'2000-01-01'}
  end
end