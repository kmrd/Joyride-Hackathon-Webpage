class AddDeviceToCoords < ActiveRecord::Migration
  def change
    add_reference :coords, :device, index: true
  end
end
