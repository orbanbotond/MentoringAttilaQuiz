FactoryGirl.define do
	factory :member do
		email "example@quiz.com"
		password "fds34d"
		confirmed_at Time.new
		
		factory :admin do
			after(:create) {|member| member.add_role(:admin)}
		end
	end

end
