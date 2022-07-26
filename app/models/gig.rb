class Gig < ApplicationRecord
  include AASM

  belongs_to :creator
  has_one :gig_payment

  aasm column: :state do
    state :applied, initial: true
    state :accepted, :completed, :paid

    event :complete do
      transitions from: [:applied, :accepted], to: :complete
    end
  end
end
