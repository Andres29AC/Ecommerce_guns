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
end
