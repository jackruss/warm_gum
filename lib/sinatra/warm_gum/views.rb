require 'sinatra/base'

module Sinatra
  module WarmGum
    module Views
      EXTENSION_METADATA = { 'participation' => { 'views' => [] } }
      METADATA_TRANSFORM = Proc.new do |message, options|
        { 'last_viewed' => message.last_viewed(options[:user_id]) }
      end

      def self.registered(app)
        Message.register_extension_metadata(EXTENSION_METADATA)
      end

    end
  end
end
