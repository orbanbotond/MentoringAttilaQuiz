FactoryGirl.define do
  factory :answer do
    trait :correct do
      correct true
    end

    trait :incorrect do
      correct false
    end
  end
end