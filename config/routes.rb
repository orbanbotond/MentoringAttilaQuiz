Rails.application.routes.draw do

  scope module: 'user' do
    resources :tests, except: [:edit]
    post 'tests/:id' => 'tests#show'
  end

  namespace :admin do
    resources :categories, except: [:show]
    resources :answers, only: [:create, :update, :destroy]
    resources :questions, except: [:show] do
    	resources :answers
    end
  end
end
