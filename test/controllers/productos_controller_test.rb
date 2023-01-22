require 'test_helper'
class ProductosControllerTest < ActionDispatch::IntegrationTest
  test 'renderizado correcto de todos los productos' do
    get productos_path
    assert_response :success
    assert_select '.producto',2
  end
  test 'renderizado correcto de la pagina del producto' do
    get producto_path(productos(:escopeta))
    assert_response :success
    assert_select '.titulo','Escopeta'
    assert_select '.descripcion', 'Escopeta de caza'
    assert_select '.precio', '1600$'
  end
  test 'renderizado correcto para productos en formularios'do 
    get new_producto_path
    assert_response :success
    assert_select 'form'
  end
  test 'permite crear un nuevo producto' do
    post productos_path, params: { producto: { titulo: 'Basuca', descripcion: 'Arma lanza cohetes', precio: 4582 } }
    assert_redirected_to productos_path
    # assert_equal flash[:notice], "Producto creado correctamente"
  end 
  test 'para que no permita crear productos nuevos con campos vacios' do
    post productos_path, params: { producto: { titulo: '', descripcion: 'Arma lanza cohetes', precio: 4582 } }
    assert_response :unprocessable_entity
  end
 
end
