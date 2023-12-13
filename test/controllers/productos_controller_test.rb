require 'test_helper'
class ProductosControllerTest < ActionDispatch::IntegrationTest
  test 'renderizado correcto de todos los productos' do
    get productos_path
    assert_response :success
    assert_select '.producto',3
    assert_select '.category',3
  end
  test 'renderizado correcto de todos los productos filtrados por categoria' do
    get productos_path(category_id: categories(:machineguns).id)
    assert_response :success
    assert_select '.producto',1
  end
  test 'renderizado correcto de la pagina del producto' do
    get producto_path(productos(:escopeta))
    assert_response :success
    assert_select '.titulo','Escopeta'
    assert_select '.info p', 'Escopeta de caza'
    #assert_select '.precio', '1600$'
    assert_select '.info .precio', '1600$'
  end
  test 'renderizado correcto para nuevos productos en formularios'do 
    get new_producto_path
    assert_response :success
    assert_select 'form'
  end
  test 'permite crear un nuevo producto' do
    post productos_path, params: { producto: { titulo: 'Basuca', descripcion: 'Arma lanza cohetes', precio: 4582,category_id: categories(:machineguns).id } }
    assert_redirected_to productos_path
    # assert_equal flash[:notice], "Producto creado correctamente"
  end 
  test 'para que no permita crear productos nuevos con campos vacios' do
    post productos_path, params: { producto: { titulo: '', descripcion: 'Arma lanza cohetes', precio: 4582 } }
    assert_response :unprocessable_entity
  end
  test 'renderizado correcto para editar productos en formularios'do 
    get edit_producto_path(productos(:metralleta))
    assert_response :success
    assert_select 'form'
  end
  test 'permite actualizar un producto' do
    patch producto_path(productos(:metralleta)), params:{
      producto:{
        precio: 2000
      }
    }
    assert_redirected_to productos_path
    #assert_equal flash[:notice], "Producto actualizado correctamente"
    assert_equal "Tu producto se ha actualizado correctamente", flash[:notice]
  end
  test 'no fue posible actualizar un producto' do
    patch producto_path(productos(:metralleta)), params:{
      producto:{
        precio: nil
      }
    }
    assert_response :unprocessable_entity
  end
  # Aqui aplicaremos TDD, para ello, primero crearemos el test, y luego lo implementaremos en el controlador.
  test 'permite eliminar un producto' do
    assert_difference('Producto.count', -1) do
      delete producto_path(productos(:metralleta))
    end
    assert_redirected_to productos_path
    #assert_equal flash[:notice], "Producto eliminado correctamente"
    assert_equal "Tu producto se ha eliminado correctamente", flash[:notice]
  end
end

# nil se utiliza para indicar que no hay valor, en este caso, no hay precio.








