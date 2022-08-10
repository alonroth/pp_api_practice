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

    # Any AR finder methods that results in a collection (where, where.not) all return an ActiveRecord::Collection (Rails wrapper for an array.)

    # .to_a turns everything in a Ruby array, GigPayment.where(state: :pending).where.not(created_at > 30.days.ago)

    GigPayment.where(state: :pending).each(&:complete!)

    # ActiveRecord scopes that are included with the aasm library.
    GigPayment.pending.each(&:complete!)

    GigPayment.pending.map(&:id) => # ['jkasdhfkajsf', 'alksjdfkjhsa', '19823yhrdfas']
  end

  def change_gig_state_to_paid
    self.gig.paid!
  end
end
