class CategoryComponent < ViewComponent::Base
  def initialize(category: nil)
    @category = category
  end
  def title
    @category ? @category.name : t('.all')
  end
  def link
    @category ? productos_path(category_id: @category.id) : productos_path
  end
  def active?
    return true if !@category && !params[:category_id]
    @category&.id == params[:category_id].to_i
  end
  def background
    active? ? "bg-gray-300" : "bg-white"
  end
  def classes
    "category text-gray-600 px-4 py-2 rounded-2xl drop-shadow-sm hover:bg-gray-300 #{background}"
  end
end
