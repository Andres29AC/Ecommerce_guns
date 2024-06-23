class FindProducts
  attr_reader :productos
  def initialize(products = initial_scope)
    @productos = products
  end
  def call(params = {})
    scoped = productos
    scoped = filter_by_category(scoped, params[:category_id])
    scoped = filter_by_price(scoped, params[:min_price])
    scoped = filter_by_price(scoped, params[:max_price])
    scoped = filter_by_query_text(scoped, params[:query_text])
    sort(scoped, params[:order_by])
  end
  private
  def initial_scope
    Producto.with_attached_photo
  end
  def filter_by_category(scoped,category_id)
    return scoped unless category_id.present?
    scoped.where(category_id: category_id)
  end
  def filter_by_price(scoped, min_price)
    return scoped unless min_price.present?
    scoped.where("precio >= ?",min_price)
  end
  def filter_by_price(scoped, max_price)
    return scoped unless max_price.present?
    scoped.where("precio <= ?",max_price)
  end
  def filter_by_query_text(scoped, query_text)
    return scoped unless query_text.present?
    scoped.search_full_text(query_text)
  end
  def sort(scoped, order_by)
    order_by_query = Producto::ORDER_BY.fetch(order_by&.to_sym, Producto::ORDER_BY[:scoped])
    scoped.order(order_by_query)
  end
end
