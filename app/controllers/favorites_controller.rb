class FavoritesController < ApplicationController
  def index
  end
  def create
    producto.favorite!
    #producto.favorites.create(user: Current.user)
    #Favorite.create(producto: producto, user: Current.user)
    redirect_to productos_path(producto)
  end
  def destroy
    producto.unfavorite!
    #producto.favorites.find_by(user: Current.user).destroy
    redirect_to productos_path(producto),status: :see_other
  end
  private
  def producto
    # Aplicando Memoization
    # Es una tecnica de optimizacion donde almacenas
    # el resultado de una operacion costosa(como una consulta a la base
    # de datos) la primera vez que se ejecuta y luego reutilizas ese
    # resultado en lugar de volver a realizar la operacion
    @producto ||= Producto.find(params[:producto_id])
  end
end
