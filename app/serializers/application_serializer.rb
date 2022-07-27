class ApplicationSerializer < ActiveModel::Serializer
  def self.attributes_list
    return self._attributes.clone.map{|s| s.to_s}
  end
end
