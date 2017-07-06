Rails.application.routes.draw do
  resources :answers, only: [:create, :update, :destroy]

  resources :questions, except: [:show] do
  	resources :answers
  end
  
  resources :categories, except: [:show]
end
