require 'sinatra/base'

module Sinatra
  module WarmGum
    module Acknowledgement

      EXTENSION_METADATA = { 'participation' => { 'acknowledged' => [] } }
      METADATA_TRANSFORM = Proc.new do |message, options|
        { 'acknowledged' => message.acknowledged?(options[:user_id]), 'acknowledged_ids' => message.acknowledged_ids }
      end

      def self.registered(app)

        Message.register_extension_metadata(EXTENSION_METADATA)

        app.put %r{^/messages/(#{app.settings.id_format})/acknowledge$} do |message_id|
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
          message_json @messages.page(params[:page]).per(settings.per_page)
        end

        app.get '/unacknowledged' do
          @messages = Message.unacknowledged(@authenticated_user.id)
          message_json @messages.page(params[:page]).per(settings.per_page)
        end
      end
    end
  end
end
