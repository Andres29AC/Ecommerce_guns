class AddNullFalseToProductoFields < ActiveRecord::Migration[7.0]
  def change
    change_column_null :productos, :titulo,:string, false
    change_column_null :productos, :descripcion,:text, false
    change_column_null :productos, :precio,:integer, false
  end 
end


