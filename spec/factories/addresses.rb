FactoryBot.define do
  factory :address do
    city { "MyString" }
    zip { "MyString" }

    trait :in_la do
      city { 'la' }
      zip { "90012" }
    end
  end
end
