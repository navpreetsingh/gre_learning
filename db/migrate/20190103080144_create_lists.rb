class CreateLists < ActiveRecord::Migration[5.2]
  def change
    create_table :lists do |t|
      t.string :word_list
      t.string :name, array: true, default: []

      t.timestamps
    end
    add_index :lists, :word_list
  end
end
