class AddStateToCoords < ActiveRecord::Migration
  def change
    add_column :coords, :state, :string
  end
end
