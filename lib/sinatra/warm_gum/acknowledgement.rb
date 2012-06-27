require 'sinatra/base'

module Sinatra
  module WarmGum
    module Acknowledgement

      EXTENSION_METADATA = { 'participation' => { 'acknowledged' => [] } }
      METADATA_TRANSFORM = Proc.new do |message, options|
        { 'acknowledged' => message.acknowledged?(options[:user_id]) }
      end

      def self.registered(app)

        Message.register_extension_metadata(EXTENSION_METADATA)

        app.put %r{^/messages/(#{ID_FORMAT})/acknowledge$} do |message_id|
          @message = Message.find(message_id)
          if @message
            @message.acknowledge!(@authenticated_user.id)
            message_json @message
          else
            status 404
            body 'Message not found'
          end
        end

        app.get '/acknowledged' do
          @messages = Message.acknowledged(@authenticated_user.id)
          message_json @messages
        end

        app.get '/unacknowledged' do
          @messages = Message.unacknowledge!(@authenticated_user.id)
          message_json @messages
        end
      end
    end
  end
end
