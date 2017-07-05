Rails.application.routes.draw do
  resources :answers
  resources :questions do
  	resources :answers
  end
  resources :categories, except: [:show]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
