require "awesome_print"
require "tapping_device/payload_helper"

class TappingDevice
  class Payload < Hash
    include PayloadHelper

    ATTRS = [
      :target, :receiver, :method_name, :method_object, :arguments, :return_value, :filepath, :line_number,
      :defined_class, :trace, :tp, :sql
    ]

    ATTRS.each do |attr|
      define_method attr do
        self[attr]
      end
    end

    def self.init(hash)
      h = new
      hash.each do |k, v|
        h[k] = v
      end
      h
    end

    def method_head
      source_file, source_line = method_object.source_location
      IO.readlines(source_file)[source_line-1]
    end

    def location
      "#{filepath}:#{line_number}"
    end
  end
end
