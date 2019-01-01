class ImageSerializer < BaseSerializer
  attributes :id, :alt, :src, :width, :height, :created_at, :updated_at, :variant_ids
end
