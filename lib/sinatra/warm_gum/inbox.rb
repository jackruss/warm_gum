require 'sinatra/base'

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
          message_json @messages.page(params[:page]).per(settings.per_page)
        end

        app.get '/archived' do
          @messages = Message.archived(@authenticated_user[:id])
          message_json @messages.page(params[:page]).per(settings.per_page)
        end

        app.put %r{^/messages/(#{app.settings.id_format})/archive$} do |message_id|
          @message = Message.find(message_id)
          @message.archive!(@authenticated_user.id)
          message_json @message
        end

      end
    end
  end
end
