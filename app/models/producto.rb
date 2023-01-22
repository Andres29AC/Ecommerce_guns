class Producto < ApplicationRecord
  validates :titulo, presence: true
  validates :descripcion, presence: true
  validates :precio, presence: true
end
