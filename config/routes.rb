SampleApp::Application.routes.draw do
  resources :users  
  resources :bands
  resources :band_members
  resources :schools
  resources :sessions, only: [:new, :create, :destroy]

  root 'static_pages#home'
  match '/signup',  to: 'users#new',            via: 'get'
  match '/signin',  to: 'sessions#new',         via: 'get'
  match '/signout', to: 'sessions#destroy',     via: 'delete'
  match '/help',    to: 'static_pages#help',    via: 'get'
  match '/about',   to: 'static_pages#about',   via: 'get'
  match '/contact', to: 'static_pages#contact', via: 'get'

  match '/static_pages/genre_select', to: 'static_pages#genre_select', via:'get'
  match '/static_pages/select_track', to: 'static_pages#select_track', via:'get'

  match '/users/select_track', to: 'users#select_track', via:'get'
  match '/users/refresh_content', to: 'users#refresh_content', via: 'get'

  match '/bands/select_track', to: 'bands#select_track', via:'get'

  match '/schools/genre_select', to: 'schools#genre_select', via:'get'
  match '/schools/select_track', to: 'schools#select_track', via:'get'

  match '/connected', to: 'users#connected_soundcloud', via: 'get'

  match '/tracks/vote_up', to: 'tracks#vote_up', via: 'get'

  get '/soundcloud/connect',    :to => 'users#connect_soundcloud',    :as => :soundcloud_connect
  get '/soundcloud/disconnect', :to => 'users#disconnect', :as => :soundcloud_disconnect

end
