require 'rails_helper'

RSpec.describe GigsController, type: :request do
  let(:creator) { Creator.create! first_name: 'First', last_name: 'Last' }
  subject { Gig.create! creator: creator, brand_name: 'brand name' }

  before(:each) do
    auth_user
  end

  it 'should change state when state sent as completed' do
    auth_put gigs_path + '/' + subject.id.to_s, {gig: {brand_name: 'New Name', creator_id: 1, state: 'completed'}}

    expect(response).to have_http_status(200)
    expect(subject.reload.state).to eq('completed')
  end

  it 'should not update gig brand name if state transition fails' do
    old_brand_name = subject.brand_name
    subject.complete!
    auth_put gigs_path + '/' + subject.id.to_s, {gig: {brand_name: 'New Name', creator_id: 1, state: 'completed'}}

    expect(response).to have_http_status(400)
    expect(subject.reload.brand_name).to eq(old_brand_name)
  end

  it 'should not update gig state if creator does not exists fails' do
    auth_put gigs_path + '/' + subject.id.to_s, {gig: {brand_name: 'New Name', creator_id: 112313, state: 'completed'}}
    expect(response).to have_http_status(400)
    expect(subject.reload.state).to eq('applied')
  end
end
