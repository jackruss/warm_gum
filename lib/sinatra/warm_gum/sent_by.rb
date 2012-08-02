require 'sinatra/base'

module Sinatra
  module WarmGum
    module SentBy
      EXTENSION_METADATA = { 'sent_by' => '' }
      METADATA_TRANSFORM = Proc.new do |message, options|
        { 'sent_by' => message.sent_by }
      end

      def self.registered(app)
        Message.register_extension_metadata(EXTENSION_METADATA)
      end

    end
  end
end
