class Category < ApplicationRecord
    has_many :productos, dependent: :restrict_with_exception
    validates :name, presence: true
end
