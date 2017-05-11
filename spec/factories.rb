FactoryGirl.define do
  factory :game do
    secret_key "123456"
    factory :game_with_no_players do
      transient do
        player_count 0
      end
      after(:create) do |game, evaluator|
        create_list(:players, evaluator.player_count, game: game)
      end
    end
    factory :game_with_one_player do
      transient do
        player_count 1
      end
      after(:create) do |game, evaluator|
        create_list(:players, evaluator.player_count, game: game)
      end
    end
    factory :game_with_two_players do
      transient do
        player_count 2
      end
      after(:create) do |game, evaluator|
        create_list(:players, evaluator.player_count, game: game)
      end
    end
  end

  factory :player do
    name "fake_name"
  end

  factory :board do
    transient do
      ship_count 5
    end
  end

  factory :cell do

  end

  factory :ship do

  end
end
