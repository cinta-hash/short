Rails.application.routes.draw do
  resources :links, path: '/' do
    member do
      get 'redirect'
    end
  end

  root 'links#new'
end
