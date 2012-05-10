require 'sinatra/base'

module Sinatra
  module WarmGum
    module Read
      EXTENSION_METADATA = { 'participation' => { 'read' => [] } }

      def self.registered(app)

        Message.register_extension_metadata(EXTENSION_METADATA)
        Message.metadata_transform do |options|
          @json_extensions.merge!('read' => read?(options[:user_id]))
        end

        app.put %r{^/messages/(#{ID_FORMAT})/read$} do |message_id|
          @message = Message.find(message_id)
          if @message
            @message.read!(@authenticated_user.id)
            json @message.as_json
          else
            status 404
            body 'Message not found'
          end
        end

        app.get '/messages/read' do
          @messages = Message.read_by_user(@authenticated_user.id)
          json @messages.as_json
        end

      end

    end
  end
end
