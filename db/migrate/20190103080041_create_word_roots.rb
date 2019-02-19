class CreateWordRoots < ActiveRecord::Migration[5.2]
  def change
    create_table :word_roots do |t|
      t.string :name
      t.string :meaning
      t.boolean :gre_root, default: false

      t.timestamps
    end
    add_index :word_roots, :name, unique: true
    add_index :word_roots, :gre_root
  end
end
