module Zoom
  class Meeting
    attr_reader :start_time, :topic, :duration, :timezone, :id, :type, :join_url

    def initialize(attributes = {})
      attributes.each { |name, value| instance_variable_set("@#{name}", value) }
    end
  end
end