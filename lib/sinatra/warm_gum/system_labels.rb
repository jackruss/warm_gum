require 'sinatra/base'

module Sinatra
  module WarmGum
    module SystemLabels
      EXTENSION_METADATA = { 'system_labels' => [] }
      METADATA_TRANSFORM = Proc.new do |message, options|
        { 'system_labels' => message.system_labels }
      end

      def self.registered(app)
        Message.register_extension_metadata(EXTENSION_METADATA)

        app.get '/messages/find_by_system_labels' do
          @messages = Message.find_by_system_labels(@authenticated_user.id, params[:system_labels])
          message_json @messages
        end
      end
    end
  end
end
