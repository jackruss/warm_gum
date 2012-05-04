require 'sinatra/base'

module Sinatra
  module WarmGum
    module Read
      EXTENSION_METADATA = { :participation => { :read => [] } }

      def self.registered(app)

        ::Message.register_extension_metadata(EXTENSION_METADATA) if defined?(Message)

        app.put '/messages/:id/read' do
          message = Message.find(params[:id])
          if message
            message.read!(@authenticated_user[:id])
          else
            status 404
            body 'Message not found'
          end
        end

        app.get '/messages/read' do
          Message.read_by_user(@authenticated_user[:id])
        end

      end
    end
  end

  register WarmGum::Read
end
