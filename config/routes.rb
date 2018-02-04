Rails.application.routes.draw do

  mount API => '/'

  devise_for :members, controllers: {
    confirmations: 'member/confirmations',
    #omniauth_callbacks: 'member/omniauth_callbacks',
    passwords: 'member/passwords',
    registrations: 'member/registrations',
    sessions: 'member/sessions',
    unlocks: 'member/unlocks'
  }


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
      resources :answers
    end
  end

  root to: "user/tests#index"
end
