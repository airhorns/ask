class CreateResponders < ActiveRecord::Migration
  def change
    create_table :responders do |t|
      t.string :phone_number

      t.timestamps
    end
  end
end
