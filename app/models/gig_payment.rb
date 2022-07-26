class GigPayment < ApplicationRecord
  include AASM

  belongs_to :gig

  aasm column: :state do
    state :pending, initial: true
    state :completed

    event :complete do
      transitions from: :pending, to: :completed
      after do
        self.change_gig_state_to_paid
      end
    end
  end

  def self.update_pending_gig_payments_to_complete
    # QUESTION: is there a better way to iterate on the query result?
    GigPayment.where({:state => 'pending'}).to_a.each{|i| i.complete!}
  end

  def change_gig_state_to_paid
    self.gig.paid!
  end
end
