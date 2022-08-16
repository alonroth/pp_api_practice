require 'rails_helper'

RSpec.describe GigPayment, :type => :model do
  let(:creator) { Creator.create! first_name: 'First', last_name: last_name }
  let(:last_name) { 'Stewart' }

  # For class methods, the name of the method prefixed with a .
  # For instance methods, the name of the method prefixed with a #
  describe '.update_pending_gig_payments_to_complete' do
    before do
      all_gigs = []
      3.times {all_gigs << (
        Gig.create! creator: creator, brand_name: 'brand name'
      )}

      # Two ways to express a Ruby block:
      # Single line can use { } - curly braces
      # Multiple lines you'll see more a do / end - all in the vain of better readability.
      3.times do
        all_gigs << Gig.create!(creator: creator, brand_name: 'brand name')
      end

      all_gigs.each do |gig|
        gig.complete!
      end
      all_gigs.first.gig_payment.complete!
    end

    it 'moves all gigs to complete' do
      GigPayment.update_pending_gig_payments_to_complete()

      # gig_payments_states = []
      # GigPayment.all.each {|gp| gig_payments_states << gp.state }

      expect(GigPayment.pluck(:state)).to all(eq('completed'))
    end
  end

  it '#change_gig_state_to_paid' do
    # TODO: 
  end

  context 'change an attribute in a let block within a deeper context' do
    let(:last_name) { 'Roth' }

    it 'does foo' do
      puts creator # last_name => 'Roth'
    end
  end


  it 'does bar' do
    puts creator # last_name => 'Stewart'
  end
end

# @@class_level_variables and globals are a SMELL
