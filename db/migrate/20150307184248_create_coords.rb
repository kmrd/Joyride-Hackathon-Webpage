class CreateCoords < ActiveRecord::Migration
  def change
    create_table :coords do |t|
      t.decimal :lat, {:precision=>10, :scale=>6}
      t.decimal :lng, {:precision=>10, :scale=>6}

      t.timestamps
    end
  end
end
