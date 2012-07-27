require 'sinatra/base'

module Sinatra
  module WarmGum
    module Read
      EXTENSION_METADATA = { 'legacy_system' => '' }
      METADATA_TRANSFORM = Proc.new do |message, options|
        { 'legacy_system' => message.legacy_system }
      end

      def self.registered(app)
        Message.register_extension_metadata(EXTENSION_METADATA)
      end

    end
  end
end
