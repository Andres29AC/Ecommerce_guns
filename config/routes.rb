Rails.application.routes.draw do
  post '/productos', to: 'productos#create'
  get '/productos/new', to: 'productos#new',as: :new_producto
  get '/productos', to: 'productos#index'
  get '/productos/:id', to: 'productos#show', as: :producto
end
#Cada vez que se haga una peticion se mandara
#a to: 'productos#index'
#Controller --productos
#Metodo --index
#dentro del metodo index declararemos
#la logica para devolver todos los productos

#show es para mostrar un unico producto

#as: sirve para darle un nombre a la ruta
