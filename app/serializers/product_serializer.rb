class ProductSerializer < ActiveModel::Serializer
  attributes :id, :title, :remote_id, :channel, :variants

  has_one :channel, serializer: ChannelSerializer
  has_many :variants, serializer: VariantSerializer
  has_many :options, serializer: OptionSerializer
  has_many :images, serializer: ImageSerializer
end
