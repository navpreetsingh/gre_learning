class RemoveWordRootFromWords < ActiveRecord::Migration[5.2]
  def change
    remove_column :words, :word_root_id, :integer
  end
end
