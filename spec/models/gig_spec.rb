require 'rails_helper'

RSpec.describe Gig, :type => :model do
  let(:creator) { Creator.create! first_name: 'First', last_name: 'Last' }
  subject { Gig.create! creator: creator, brand_name: 'brand name' }

  it 'should create a gig payment once gig completes' do
    subject.complete!
    expect(subject.gig_payment).to be_an_instance_of(GigPayment)
  end
end
