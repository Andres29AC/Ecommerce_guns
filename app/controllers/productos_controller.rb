class ProductosController < ApplicationController
  def index
    @categories = Category.order(name: :asc).load_async.load
    @productos=Producto.with_attached_photo
    if params[:category_id]
      @productos = @productos.where(category_id: params[:category_id])
    end
    if params[:min_price].present?
      @productos = @productos.where("precio >= ?",params[:min_price])
    end
    if params[:max_price].present?
      @productos = @productos.where("precio <= ?",params[:max_price])
    end
    if params[:query_text].present?
      @productos = @productos.search_full_text(params[:query_text])
    end
    # if params[:order_by].present?
    #   order_by = {
    #     newest: "created_at DESC",
    #     expensive: "precio DESC",
    #     cheaper: "precio ASC"
    #   }.fetch(params[:order_by].to_sym, "created_at DESC")
      
    #   @productos = @productos.order(order_by)
    # end
    order_by = Producto::ORDER_BY.fetch(params[:order_by]&.to_sym, Producto::ORDER_BY[:newest])
      
    @productos = @productos.order(order_by).load_async.load
  end
  def show
    @producto=Producto.find(params[:id])

  end
  def new
    @producto=Producto.new
  end
  def create
    @producto=Producto.new(producto_params)
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
    @producto = Producto.find(params[:id])
    #find se encarga de buscar el producto por id para poder editarlo

  end
  def update
    @producto = Producto.find(params[:id])
    if @producto.update(producto_params)
      redirect_to productos_path, notice: t('.updated')
    else
      render :edit, status: :unprocessable_entity
    end
  end
  def destroy
    @producto = Producto.find(params[:id])
    @producto.destroy
    redirect_to productos_path, notice: t('.deleted') ,status: :see_other
  end
  private
  def producto_params
    params.require(:producto).permit(:titulo,:descripcion,:precio,:photo,:category_id)
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
