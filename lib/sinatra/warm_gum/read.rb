module Sinatra
  module WarmGum
    module Read
      EXTENSION_METADATA = { 'participation' => { 'read' => [] } }
      METADATA_TRANSFORM = Proc.new do |message, options|
        { 'read' => message.read?(options[:user_id]) }
      end

      def self.registered(app)

        Message.register_extension_metadata(EXTENSION_METADATA)

        app.put %r{^/messages/(#{app.settings.id_format})/read$} do |message_id|
          @message.read!(@authenticated_user.id)
          message_json @message
        end

        app.get '/read' do
          @messages = Message.read(@authenticated_user.id)
          message_json @messages.page(params[:page]).per(settings.per_page)
        end

        app.get '/unread' do
          @messages = Message.unread(@authenticated_user.id)
          message_json @messages.page(params[:page]).per(settings.per_page)
        end

      end

    end
  end
end
