class GigSerializer < ActiveModel::Serializer
  attributes :id, :state, :brand_name
  has_one :gig_payment, serializer: GigPaymentSerializer
  has_one :creator
end
