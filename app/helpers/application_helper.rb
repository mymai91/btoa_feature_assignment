# frozen_string_literal: true

module ApplicationHelper
  def serialize_fields(data)
    ActiveModelSerializers::SerializableResource.new(data)
  end
end
