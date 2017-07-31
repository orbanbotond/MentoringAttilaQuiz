Rails.application.routes.draw do

  resources :users
  scope module: 'user' do
    resources :tests, except: [:edit]
    post 'tests/:id' => 'tests#show'
    get 'tests/:id/answer_questions' => 'tests#answer_questions'
    post 'tests/:id/answer_questions' => 'tests#answer_questions'
  end

  namespace :admin do
    resources :categories, except: [:show]
    #TODO hint please consider nesting the answers to the question
    resources :answers, only: [:create, :update, :destroy]
    resources :questions, except: [:show] do
      #TODO replace tabs with spaces
    	resources :answers
    end
  end
end
