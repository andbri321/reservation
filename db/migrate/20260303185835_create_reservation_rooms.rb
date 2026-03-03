class CreateReservationRooms < ActiveRecord::Migration[8.0]
  def change
    create_table :reservation_rooms do |t|
      t.datetime :date
      t.references :user, null: false, foreign_key: true
      t.references :room, null: false, foreign_key: true

      t.timestamps
    end
  end
end
