require 'sinatra/base'
require 'sinatra/json'

module Sinatra
  module WarmGum
    module Inbox
      EXTENSION_METADATA = { 'participation' => { 'archived' => [] } }

      def self.registered(app)

        Message.register_extension_metadata(EXTENSION_METADATA)
        Message.metadata_transform do |options|
          @json_extensions.merge!('archived' => archived?(options[:user_id]))
        end

        app.get '/inbox' do
          @messages = Message.inbox(@authenticated_user[:id])
          json @messages.as_json
        end

        app.get '/messages/archived' do
          @messages = Message.archived_by_user(@authenticated_user[:id])
          json @messages.as_json
        end

        app.put %r{^/messages/(#{ID_FORMAT})/archive$} do |message_id|
          @message = Message.find(message_id)
          @message.archive!(@authenticated_user.id)
          json @message.as_json
        end

      end
    end
  end
end
