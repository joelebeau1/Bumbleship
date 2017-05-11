FactoryGirl.define do
  factory :game do
    secret_key "123456"
  end

  factory :player do
    sequence :name { |n| "player#{n}" }
  end

  factory :board do
    player
    game
  end

  factory :cell do
    # sequence(:x_coordinate) { |n|  }
    # sequence(:y_coordinate) {}

    coordinates { "#{x_coordinate}#{y_coordinate}" }
    guessed { [true, false].sample }
    board
  end

  factory :ship do
    sequence :name { |n| "ship#{n}" }
    length { rand(2..5) }
    board
  end
end
