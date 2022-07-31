require 'rails_helper'

RSpec.describe Gig, :type => :model do
  before do
    @creator = Creator.create! first_name: 'First', last_name: 'Last'
    @gig = Gig.create! creator: @creator, brand_name: 'brand name'
  end

  it 'should create a gig payment once gig completes' do
    @gig.complete!
    expect(@gig.gig_payment).to be_an_instance_of(GigPayment)
  end
end
