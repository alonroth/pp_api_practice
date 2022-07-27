# QUESTION: Do I have to create a serializer in order for the relationship to be printed in GET /gigs/<id>?
class CreatorSerializer < ApplicationSerializer
  attributes :id, :first_name, :last_name
  belongs_to :gig, serializer: GigSerializer
end
