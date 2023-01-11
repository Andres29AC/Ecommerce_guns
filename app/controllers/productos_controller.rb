class ProductosController < ApplicationController
  def index
    @productos=Producto.all
  end
  def show
    @producto=Producto.find(params[:id])

  end
end
# < sirve para heredar
# Modelo -- Todo relacionado con la Base de Datos
#           consultas,validaciones,relaciones
# Vista -- Devolver al usuario html,pdf,csv,json
# Controlador -- Logica del proyecto
# @productos -- es una variable de instancia
# Tienda en proceso
