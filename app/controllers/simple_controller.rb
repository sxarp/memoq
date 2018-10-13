class SimpleController < ApplicationController
  def index
    object = Struct.new(:id, :content).new(1, "simple")
    serializer = SimpleSerializer.new(object)
    render json: serializer.serialized_json
  end
end
