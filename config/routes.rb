Rails.application.routes.draw do
  devise_for :users

  if Rails.env.development?
    mount Lookbook::Engine, at: "/lookbook"
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # namespace :library do
  #   resources :checklists do
  #     member do
  #       post :copy_to_workspace
  #       post :publish
  #     end
  #   end
  # end

  resources :checklists do
    resources :instances, controller: "checklist_instances"
    member do
      get :details
    end
  end

  namespace :settings do
    resource :account, only: %i[show update]
  end

  # resources :libraries, only: %i[index show] do
  #   collection do
  #     get :personal
  #   end
  # end

  # resources :workspaces, only: %i[index show] do
  #   collection do
  #     get :personal
  #   end

  #   member do
  #     get :settings
  #   end
  # end

  resource :workspace, only: :show

  # namespace :workspace do
  #   resources :checklists
  # end

  resources :checklist_instances do
    resources :checklist_items, only: %i[update]
  end

  root to: "home#index"
end
