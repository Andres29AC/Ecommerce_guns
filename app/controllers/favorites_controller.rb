class FavoritesController < ApplicationController
  def index
  end
  def create
    producto.favorite!
    respond_to do |format|
      format.html do
        redirect_to productos_path(producto)
      end
      format.turbo_stream do
        render turbo_stream: turbo_stream.replace("favorite", partial: "productos/favorite", locals: { producto: producto })
      end
    end
    #producto.favorites.create(user: Current.user)
    #Favorite.create(producto: producto, user: Current.user)
    #redirect_to productos_path(producto)
  end
  def destroy
    producto.unfavorite!
    respond_to do |format|
      format.html do
        redirect_to productos_path(producto),status: :see_other
      end
      format.turbo_stream do
        render turbo_stream: turbo_stream.replace("favorite", partial: "productos/favorite", locals: { producto: producto })
      end
    end
    #producto.favorites.find_by(user: Current.user).destroy
    #redirect_to productos_path(producto)
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
