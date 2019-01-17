class CreateLists < ActiveRecord::Migration[5.2]
  def change
    create_table :lists do |t|
      t.string :company
      t.string :person
      t.string :memo

      t.timestamps
    end
  end
end
