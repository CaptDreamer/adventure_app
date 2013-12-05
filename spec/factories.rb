FactoryGirl.define do
  factory :user do
    first_name     	"Michael"
    last_name 	   	"Hartl"
    username		"MHartl"
    email    		"michael@example.com"
    password 		"foobar"
    password_confirmation "foobar"

    factory :admin do
      admin true
    end
  end

  factory :post do
  	title			"Example Post"
  	content			"Lorem ipsum"
    user
  end
end
