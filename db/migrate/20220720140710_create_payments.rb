class CreatePayments < ActiveRecord::Migration[6.0]
  def change
    create_table :payments do |t|
      t.string :state, default: 'pending'

      t.timestamps
    end
  end
end