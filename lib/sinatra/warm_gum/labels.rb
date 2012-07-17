require 'sinatra/base'

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
          @message = Message.find(message_id)
          if @message.add_label!(params[:label])
            message_json @message
          else
            halt 403, json('error' => 'Error adding label')
          end
        end

        app.delete %r{/messages/(#{app.settings.id_format})/labels} do |message_id|
          @message = Message.find(message_id)
          if @message.remove_label!(params[:label])
            message_json @message
          else
            halt 403, json('error' => 'Label does not exist')
          end
        end

      end
    end
  end
end
