Rails.application.routes.draw do

  scope module: 'user' do
    resources :tests, except: [:edit]
    post 'tests/:id' => 'tests#show'
    get 'tests/:id/answer_questions' => 'tests#answer_questions'
    post 'tests/:id/answer_questions' => 'tests#answer_questions'
  end

  namespace :admin do
    resources :categories, except: [:show]
    resources :answers, only: [:create, :update, :destroy]
    resources :questions, except: [:show] do
    	resources :answers
    end
  end
end
