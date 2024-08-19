class ProductoPolicy < BasePolicy
  def edit
    #record.user_id == Current.user.id
    record.owner?
  end
  def update
    #record.user_id == Current.user.id
    record.owner?
  end
  def destroy
    #record.user_id == Current.user.id
    record.owner?
  end
end
