FactoryGirl.define do
  factory :question do
    category

    after(:build) do |question|
      question.answers << FactoryGirl.create(:answer, :incorrect, name: "First answer", question: question)
      question.answers << FactoryGirl.create(:answer, :correct, name: "Second correct", question: question)
      question.answers << FactoryGirl.create(:answer, :correct, name: "Third correct", question: question)
    end
  end
end