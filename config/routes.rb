Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: "users/sessions",
  }

  root 'static_pages#top'
  get 'static_pages/top', to: 'static_pages#top'
  get 'static_pages/privacy', to: 'static_pages#privacy'
  get 'static_pages/term', to: 'static_pages#term'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
