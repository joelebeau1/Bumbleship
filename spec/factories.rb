FactoryGirl.define do
  sequence :player_name do |n|
    "player#{n}"
  end

  sequence :ship_name do |n|
    "ship#{n}"
  end

  sequence :secret_key_number, 100000 do |n|
    key = 10**5 + n
    key.to_s
  end

  factory :game do
    secret_key { generate(:secret_key_number) }
  end

  factory :player do
    name { generate(:player_name) }
  end

  factory :board do
  end

  factory :cell do
    guessed { [true, false].sample }
    coordinates "A2"
  end

  factory :ship do
    name { generate(:ship_name) }
    length { rand(2..5) }
  end
end
