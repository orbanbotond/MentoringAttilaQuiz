Rails.application.routes.draw do

  scope module: 'user' do
    resources :tests do
      post '/' => 'tests#check'
    end
  end

  namespace :admin do
    resources :categories, except: [:show]
    resources :answers, only: [:create, :update, :destroy]
    resources :questions, except: [:show] do
    	resources :answers
    end
  end
end
