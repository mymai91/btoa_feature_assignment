Rails.application.routes.draw do

  namespace :api do
    namespace :v1 do
      # resources :setting
      get 'setting/info'
      get 'setting/manage_table'
      post 'setting/access_scope'
      get 'income/index'
    end
  end

  root to: 'pages#index'
  match "*path", to: "pages#index", via: :all
end
