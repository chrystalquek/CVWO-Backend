Rails.application.routes.draw do
  # good practice to declare route as /api
  scope '/api' do
    post "/login", to: "auth#login"
    post "/signup", to: "users#create"
    get "/auto_login", to: "auth#auto_login"
  # reflects users has many todos, and todo belongs to user relationship
    resources :users do
      resources :todos
    end
  end
   
end


