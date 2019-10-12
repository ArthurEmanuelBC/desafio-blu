class RenameTypeToCode < ActiveRecord::Migration[5.2]
  def change
    rename_column :transaction_types, :type, :code
  end
end
