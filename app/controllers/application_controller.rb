class ApplicationController < ActionController::Base
  include CurrentContext

  private

    def respond(serializer_class, object)
      serializer = serializer_class.new(object)
      render json: serializer.serialized_json
    end
end
