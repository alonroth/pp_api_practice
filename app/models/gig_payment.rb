class GigPayment < ApplicationRecord
  belongs_to :gig

  def self.update_pending_gig_payments_to_complete
    GigPayment.where({:state => 'pending'}).update_all({:state => 'complete'}) # TODO: Change to constants
  end
end
