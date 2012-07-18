require 'sinatra/base'

module Sinatra
  module WarmGum
    module SystemLabels
      EXTENSION_METADATA = { 'system_labels' => [] }
      METADATA_TRANSFORM = Proc.new do |message, options|
        { 'system_labels' => message.system_labels }
      end

      def self.registered(app)
        Message.register_extension_metadata(EXTENSION_METADATA)
      end
    end
  end
end
