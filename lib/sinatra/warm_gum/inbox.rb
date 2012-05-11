require 'sinatra/base'
require 'sinatra/json'

module Sinatra
  module WarmGum
    module Inbox
      EXTENSION_METADATA = { 'participation' => { 'archived' => [] } }
      METADATA_TRANSFORM = Proc.new do |message, options|
        { 'archived' => message.archived?(options[:user_id]) }
      end

      def self.registered(app)

        Message.register_extension_metadata(EXTENSION_METADATA)

        app.get '/inbox' do
          @messages = Message.inbox(@authenticated_user[:id])
          message_json @messages
        end

        app.get '/messages/archived' do
          @messages = Message.archived_by_user(@authenticated_user[:id])
          message_json @messages
        end

        app.put %r{^/messages/(#{ID_FORMAT})/archive$} do |message_id|
          @message = Message.find(message_id)
          @message.archive!(@authenticated_user.id)
          message_json @message
        end

      end
    end
  end
end
