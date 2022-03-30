Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "application#index"
  get "/buscar", to: "application#buscar", as: "buscar"
  get "/buscar/(:busca)/(:page)", to: "application#buscar", as: "buscar_params"
end
