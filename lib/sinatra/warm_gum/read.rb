require 'sinatra/base'

module Sinatra
  module WarmGum
    module Read
      EXTENSION_METADATA = { 'participation' => { 'read' => [] } }
      METADATA_TRANSFORM = Proc.new do |message, options|
        { 'read' => message.read?(options[:user_id]) }
      end

      def self.registered(app)

        Message.register_extension_metadata(EXTENSION_METADATA)

        app.put %r{^/messages/(#{ID_FORMAT})/read$} do |message_id|
          @message = Message.find(message_id)
          if @message
            @message.read!(@authenticated_user.id)
            message_json @message
          else
            status 404
            body 'Message not found'
          end
        end

        app.get '/read' do
          @messages = Message.read(@authenticated_user.id)
          message_json @messages.page(params[:page]).per(PER_PAGE)
        end

        app.get '/unread' do
          @messages = Message.unread(@authenticated_user.id)
          message_json @messages.page(params[:page]).per(PER_PAGE)
        end

      end

    end
  end
end
