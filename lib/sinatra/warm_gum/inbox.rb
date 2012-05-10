require 'sinatra/base'
require 'sinatra/json'

module Sinatra
  module WarmGum
    module Inbox
      EXTENSION_METADATA = { 'participation' => { 'archived' => [] } }

      def self.registered(app)

        Message.register_extension_metadata(EXTENSION_METADATA)

        app.get '/inbox' do
          @messages = Message.inbox(@authenticated_user[:id])
          json @messages
        end

        app.get '/messages/archived' do
          @messages = Message.archived_by_user(@authenticated_user[:id])
          json @messages
        end

        app.put %r{^/messages/#{ID_FORMAT}/archive$} do
          @message = Message.find(params[:id])
          @message.archive!(@authenticated_user[:id])
          json @message
        end

      end
    end
  end
end
