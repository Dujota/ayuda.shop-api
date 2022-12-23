# Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

Rails.application.routes.draw do
  # TODO REMOVE or Replace with get token?
  get "/current-user", to: "current_user#index"

  namespace :api do
    namespace :v1 do
      resources :listings
    end
  end

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
