class ChangePaymentToGigPayment < ActiveRecord::Migration[6.0]
  def change
    rename_table :payments,:gig_payments
  end
end
