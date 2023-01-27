Rails.application.routes.draw do
  delete '/productos/:id', to: 'productos#destroy'
  patch '/productos/:id', to: 'productos#update'
  post '/productos', to: 'productos#create'
  get '/productos/new', to: 'productos#new',as: :new_producto
  get '/productos', to: 'productos#index'
  get '/productos/:id', to: 'productos#show', as: :producto
  get '/productos/:id/edit', to: 'productos#edit', as: :edit_producto
end
#Cada vez que se haga una peticion se mandara
#a to: 'productos#index'
#Controller --productos
#Metodo --index
#dentro del metodo index declararemos
#la logica para devolver todos los productos

#show es para mostrar un unico producto

#as: sirve para darle un nombre a la ruta
