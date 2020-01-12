Rails.application.routes.draw do
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  scope '/api' do
    post "/login", to: "auth#login"
    post "/signup", to: "users#create"
    get "/auto_login", to: "auth#auto_login"
    resources :users, only: [:create] do
      resources :todos
    end
  end
  #  post "/login", to: "auth#login"
  #  get "/auto_login", to: "auth#auto_login"
   
end


