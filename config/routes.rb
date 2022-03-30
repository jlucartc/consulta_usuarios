Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "application#buscar"
  get "/buscar/(:busca)/:page", to: "application#buscar", as: "busca"
  get "/buscar/:page", to: "application#buscar", as: "busca_inicial"
end
