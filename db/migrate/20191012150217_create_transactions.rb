class CreateTransactions < ActiveRecord::Migration[5.2]
  def change
    create_table :transactions do |t|
      t.datetime :date
      t.float :value
      t.string :cpf, length: 11
      t.string :card, length: 12
      t.string :store_owner, length: 14
      t.string :store, length: 19
      t.references :transaction_type, foreign_key: true

      t.timestamps
    end
  end
end
