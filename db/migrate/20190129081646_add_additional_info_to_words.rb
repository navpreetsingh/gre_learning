class AddAdditionalInfoToWords < ActiveRecord::Migration[5.2]
  def change
    add_column :words, :additional_info, :jsonb
  end
end
