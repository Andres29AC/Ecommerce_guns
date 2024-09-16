module Favoritable
  extend ActiveSupport::Concern
  included do
    has_many :favorites, dependent: :destroy
    def favorite!
      favorites.create(user: Current.user)
    end
    def unfavorite!
      #favorites.find_by(user: Current.user).destroy
      favorite.destroy
    end
    def favorite
      favorites.find_by(user: Current.user)
    end
  end
end
