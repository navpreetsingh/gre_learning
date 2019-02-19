class CreateWords < ActiveRecord::Migration[5.2]
  def change
    create_table :words do |t|
      t.string :name
      t.string :speech
      t.string :meaning
      t.text :sentence
      t.jsonb :meta_data

      t.boolean :meta_fetched, default: false
      t.boolean :frequently_occuring, default: false
      t.boolean :commonly_mistaken_words, default: false
      t.boolean :high_frequency_words, default: false
      t.string :group

      t.boolean :parent, default: false
      t.references :parent, null: true, index: true, where: 'parent_id IS NOT NULL'
      t.references :list, default: 1, index: true, where: 'list_id IS NOT NULL'
      t.references :word_root, index: true, where: 'word_root_id IS NOT NULL'

      t.timestamps
    end
    add_index :words, :name, unique: true
    add_index :words, :group
  end
end
