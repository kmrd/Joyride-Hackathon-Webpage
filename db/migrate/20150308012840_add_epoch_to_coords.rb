class AddEpochToCoords < ActiveRecord::Migration
  def change
    add_column :coords, :epoch, :integer
  end
end
