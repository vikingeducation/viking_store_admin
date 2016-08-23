Rails.application.routes.draw do

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get 'dashboard', to: 'dashboards#index'
  resources :categories, only: [:new, :create, :index, :show, :edit, :destroy]
end
