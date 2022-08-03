require 'rails_helper'

RSpec.describe GigPayment, :type => :model do
  let(:creator) { Creator.create! first_name: 'First', last_name: 'Last' }
  it 'should update pending gig payments to complete' do
    all_gigs = []
    3.times {all_gigs << (
      Gig.create! creator: creator, brand_name: 'brand name'
    )}
    all_gigs.each{|g| g.complete!}
    all_gigs[0].gig_payment.complete!
    GigPayment.update_pending_gig_payments_to_complete()

    gig_payments_states = []
    GigPayment.all.each {|gp| gig_payments_states << gp.state }
    expect(gig_payments_states).to all(eq('completed'))
  end
end
