Rails.application.routes.draw do
  namespace :authentication, path: '', as: '' do
    resources :users, only: [:new, :create],path: '/register',path_names: {new: '/'}
    resources :sessions, only: [:new, :create, :destroy],path: '/login',path_names: {new: '/'}
  end
  resources :favorites, only: [:index,:create, :destroy], param: :producto_id
  resources :users, only: :show, path: '/user',param: :username
  resources :categories, except: :show
  resources :productos, path: '/'
end

#NOTE
# para convertir a singular utilizo path para cambiar la url
