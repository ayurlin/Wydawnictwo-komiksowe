Rails.application.routes.draw do

  root to:'pages#index'

  mount Bootsy::Engine => '/bootsy', as: 'bootsy'
  resources :series, :path => '/admin/series'
  resources :editors, :path => '/admin/editors'
  resources :slides, :path => '/admin/slides'
  devise_for :users, :skip => [:registrations, :sessions]                                          
  as :user do
    get 'signin' => 'devise/sessions#new', :as => :new_user_session
    post 'signin' => 'devise/sessions#create', :as => :user_session
    delete 'signout' => 'devise/sessions#destroy', :as => :destroy_user_session
    get 'admin/change_password' => 'devise/registrations#edit', :as => 'edit_user_registration'    
    put 'users' => 'devise/registrations#update', :as => 'user_registration'
  end
  get '/admin' => 'admin#index', as: :admin
  get "/admin/enqueue_elibri" => "admin#enqueue_elibri", as: :enqueue_elibri
  get '/zapowiedzi' => 'pages#preorders', as: 'preorders'
  get '/lista-produktow' => 'pages#products_list', as: 'products_list'
  get '/foreign-rights' => 'pages#foreign_rights', as: 'foreign_rights'
  get '/kontakt' => 'pages#contact', as: 'contact'
  get '/seria/:id' => 'pages#by_series', as: 'by_series'
  get '/autor/:id' => 'pages#author', as: 'autor'
  get '/book/:id' => 'book#show'
  get '/preview/:id' => "book#preview", as: :preview
  get 'admin/slide/:id' => 'slides#edit', as: 'slide_show'

  get ':id' => "book#show", as: :book

end
