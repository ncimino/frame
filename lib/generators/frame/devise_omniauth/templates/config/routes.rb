Deom::Application.routes.draw do
  devise_for :users, path_names: {sign_in: "login", sign_out: "logout"},
             controllers: {omniauth_callbacks: "omniauth_callbacks"}
  resources :pages
  get 'sessions/new'
  root :to => 'pages#show', :id => 0
end
