class CreateJoinTableRootCategory < ActiveRecord::Migration[5.2]
  def change
    create_join_table :word_roots, :words do |t|
      t.index [:word_root_id, :word_id], unique: true
      # t.index [:_id, :_id]
    end
  end
end
