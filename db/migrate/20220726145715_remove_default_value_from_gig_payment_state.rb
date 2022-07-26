class RemoveDefaultValueFromGigPaymentState < ActiveRecord::Migration[6.0]
  def change
    change_column_default(:gig_payments, :state, nil)
  end
end
