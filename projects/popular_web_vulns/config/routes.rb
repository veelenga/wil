Rails.application.routes.draw do
  resources :posts do
    collection do
      get :search
    end

    member do
      get :rank
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
