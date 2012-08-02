module Sinatra
  module WarmGum
    module Labels
      EXTENSION_METADATA = { 'labels' => [] }
      METADATA_TRANSFORM = Proc.new do |message, options|
        { 'labels' => message.labels }
      end

      def self.registered(app)

        Message.register_extension_metadata(EXTENSION_METADATA)

        app.put %r{/messages/(#{app.settings.id_format})/labels} do |message_id|
          halt 403, app.settings.errors[290] unless @message.add_label!(params[:label])
          message_json @message
        end

        app.delete %r{/messages/(#{app.settings.id_format})/labels} do |message_id|
          halt 403, app.settings.errors[291] unless @message.remove_label!(params[:label])
          message_json @message
        end

      end
    end
  end
end
