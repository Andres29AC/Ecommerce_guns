class ProductosController < ApplicationController
  def index
    @productos=Producto.all
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
      redirect_to productos_path, notice: 'Producto creado correctamente'
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
      redirect_to productos_path, notice: 'Producto actualizado correctamente'
    else
      render :edit, status: :unprocessable_entity
    end
  end
  def destroy
    @producto = Producto.find(params[:id])
    @producto.destroy
    redirect_to productos_path, notice: 'Producto eliminado correctamente',status: :see_other
  end
  private
  def producto_params
    params.require(:producto).permit(:titulo,:descripcion,:precio)
  end
end

# < sirve para heredar
# Modelo -- Todo relacionado con la Base de Datos
#           consultas,validaciones,relaciones
# Vista -- Devolver al usuario html,pdf,csv,json
# Controlador -- Logica del proyecto
# @productos -- es una variable de instancia
# Tienda en proceso
