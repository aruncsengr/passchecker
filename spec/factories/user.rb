FactoryBot.define do
  factory :user do
    name { 'Testuser' }

    trait :with_sequential_3_chars do
      password { 'AAAfk1swods' }
    end

    trait :with_non_sequential_3_chars do
      password { 'QPFJWz1343439' }
    end
  end
end


