class ChangeDataTypeForLongUrl < ActiveRecord::Migration[7.1]
  def change
    change_column :links, :long_url, :text
  end
end
