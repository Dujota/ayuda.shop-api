# Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :listings
    end
  end

  scope "/api/v1", defaults: { format: :json } do
    scope "/nextauth" do
      post "/oauth", to: "users/next_oauth#oauth"
      post "/token", to: "users/next_oauth#verify_user"
      # post "/google", to: "users/next_oauth#google"
      # post "/discord", to: "uses/next_oauth#discord"
      # post "/facebook", to: "users/next_oauth#facebook"
    end
  end

  # TODO REMOVE or Replace with get token?
  get "/current-user", to: "current_user#index"

  devise_for :users,
             path: "",
             path_names: {
               sign_in: "login",
               sign_out: "logout",
               registration: "signup"
             },
             controllers: {
               sessions: "users/sessions",
               registrations: "users/registrations"
             },
             defaults: {
               format: :json
             }
end
