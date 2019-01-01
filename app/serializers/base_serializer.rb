class BaseSerializer < ActiveModel::Serializer
  def read_attribute_for_serialization(attr)
    return send(attr) if respond_to?(attr)

    object[attr.to_s]
  end
end
