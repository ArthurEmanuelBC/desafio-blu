class CreateTransactionTypes < ActiveRecord::Migration[5.2]
  def change
    create_table :transaction_types do |t|
      t.string :type, length: 1
      t.string :description
      t.string :nature, length: 7
      t.string :signal, length: 1

      t.timestamps
    end
  end
end
