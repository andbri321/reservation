class CreateUsers < ActiveRecord::Migration[8.0]
  def change
    create_table :users do |t|
      t.string :name
      t.string :registration
      t.string :position

      t.timestamps
    end
  end
end
