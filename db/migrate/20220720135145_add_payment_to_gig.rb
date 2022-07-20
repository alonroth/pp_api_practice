class AddPaymentToGig < ActiveRecord::Migration[6.0]
  def change
    add_column :gigs, :payment, :has_one
  end
end
