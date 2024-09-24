class ProductosController < ApplicationController
  skip_before_action :protect_pages, only: [:index, :show]
  def index
    @categories = Category.order(name: :asc).load_async.load

    @pagy, @productos = pagy_countless(FindProducts.new.call(producto_params_index).load_async, items: 10)
  end
  def show
    @producto=Producto.find(params[:id])
  end
  def new
    @producto=Producto.new
  end
  def create
    @producto = Producto.new(producto_params)
    # @producto=Current.user.productos.new(producto_params)
    # pp @producto
    if @producto.save
      redirect_to productos_path, notice: t('.created')  
    else
      render :new, status: :unprocessable_entity
      # explicacion: si no se guarda el producto, se renderiza la vista new
      # y se le pasa el status 422
    end 
  end
  def edit
    authorize! producto
    #@producto = Producto.find(params[:id])
    #find se encarga de buscar el producto por id para poder editarlo
  end
  def update
    authorize! producto
    @producto = Producto.find(params[:id])
    if @producto.update(producto_params)
      redirect_to productos_path, notice: t('.updated')
    else
      render :edit, status: :unprocessable_entity
    end
  end
  def destroy
    authorize! producto
    @producto = Producto.find(params[:id])
    @producto.destroy
    redirect_to productos_path, notice: t('.deleted') ,status: :see_other
  end
  private
  def producto_params
    params.require(:producto).permit(:titulo,:descripcion,:precio,:photo,:category_id)
  end
  def producto_params_index
    params.permit(:category_id,:min_price,:max_price,:query_text,:order_by,:page,:favorites,:user_id)
  end
  def producto
    @producto = Producto.find(params[:id])
  end
end

# < sirve para heredar
# Modelo -- Todo relacionado con la Base de Datos
#           consultas,validaciones,relaciones
# Vista -- Devolver al usuario html,pdf,csv,json
# Controlador -- Logica del proyecto
# @productos -- es una variable de instancia
# Tienda en proceso

#TODO: COMANDO MAGICO DE ruby on rails:
#TODO: ->rails generate scaffold Category name:string description:string{255}
#TODO: ->Siempre que se aplique esto de debe aplicar tambien rails db:migrate
#TODO: ->para ver las peticiones: /rails/info/routes
#TODO: ->para limpiar la base de datos rails db:reset
#TODO: ->para habilitar la consola utiliza rails console
#TODO: ->para ActiveRecord::Base.connection.table_exists?(:products) para verificar si existe una tabla
#TODO: ->para rellenar desde terminal usando las fixtures rails db:fixtures:load
#TODO: ->bundle add pg_search
