class Producto < ApplicationRecord
  has_one_attached :photo
  validates :titulo, presence: true
  validates :descripcion, presence: true
  validates :precio, presence: true
end
