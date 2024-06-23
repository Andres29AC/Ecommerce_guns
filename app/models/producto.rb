class Producto < ApplicationRecord
  include PgSearch::Model
  pg_search_scope :search_full_text, against: {
    titulo: 'A',
    descripcion: 'B'
  }
  ORDER_BY = {
     newest: "created_at DESC",
     expensive: "precio DESC",
     cheaper: "precio ASC"
  }
  has_one_attached :photo
  validates :titulo, presence: true
  validates :descripcion, presence: true
  validates :precio, presence: true
  belongs_to :category
  belongs_to :user, default: -> { Current.user }
end
