Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    passwords:     'users/passwords',
    sessions: "users/sessions",
  }
  devise_scope :user do
    get 'login', to: 'users/sessions#new'
    post 'login', to: 'users/sessions#create'
    delete 'signout', to: 'users/sessions#destroy'
    post 'guest_sign_in', to: 'users/sessions#guest_sign_in'
  end


  root 'static_pages#top'
  get 'top', to: 'static_pages#top'
  get 'privacy', to: 'static_pages#privacy'
  get 'term', to: 'static_pages#term'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :posts, only: %i[index edit create destroy update] do
    resource :likes, only: %i[create destroy]
    resource :calms, only: %i[create destroy]
    resource :cheers, only: %i[create destroy]
  end

end
