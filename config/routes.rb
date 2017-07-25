Rails.application.routes.draw do
  resources :drop_off_packages do
    collection do
      get 'receipt'
    end
  end
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
