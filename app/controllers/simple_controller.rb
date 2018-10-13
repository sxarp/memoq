class SimpleController < ApplicationController
  def index
    object = Struct.new(:id, :content).new(1, "simple")
    respond SimpleSerializer, object
  end
end
