require 'sinatra/base'
require 'sinatra/json'

module Sinatra
  module WarmGum
    module Base
      WRITEABLE_MESSAGE_ATTRIBUTES = [:subject, :body]

      def self.registered(app)

        app.get '/user' do
          json @authenticated_user
        end

        app.get '/messages/:id' do
          json Message.find(params[:id])
        end

        app.get '/messages' do
          json Message.by_user(@authenticated_user[:id])
        end

        app.post '/messages' do
          message = params[:message].select { |attr, val| WRITEABLE_MESSAGE_ATTRIBUTES.include?(attr.to_sym) }
          message[:from] = @authenticated_user[:id]
          json Message.create_with_metadata(message)
        end

        app.get '/sent' do
          json Message.sent_by_user(@authenticated_user[:id])
        end

        app.get '/drafts' do
          json Message.by_state('draft')
        end

        app.put '/messages/:id/deliver' do
          message = Message.find(params[:id])
          if message.delivered?
            halt
          else
            message.deliver
          end
        end

      end
    end
  end

  register WarmGum::Base
end
