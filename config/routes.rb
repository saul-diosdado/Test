# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :admin do
   
    resources :roles
    resources :users

    
  end
  root 'profiles#index'

  resources :profiles do
    member do
      get :delete
    end
  end

  resources :answers do
    member do
      get :delete
    end
  end

  resources :preferences do
    member do
      get :delete
    end
  end

  resources :questions do
    member do
      get :delete
    end
  end

  resources :preference_forms do
    member do
      get :delete
    end
  end

  resources :matches do
    member do
      get :delete
    end

    get 'edit_search'
    get 'edit_unmatched'
  end

  resources :public_forms, only: [:index]

  resources :personalities, only: [:index]
  get 'personalities/myersBriggs'
  get 'personalities/conflictManagement'
  get 'personalities/trueColors'
  get 'personalities/enneagram'
  get 'personalities/conflictManagementFox'
end
