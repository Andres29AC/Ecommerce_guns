class AddUserToProduct < ActiveRecord::Migration[7.0]
  def change
    add_reference :productos, :user, null: false, foreign_key: true
  end
end
