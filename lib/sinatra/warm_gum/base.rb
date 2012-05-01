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
          json Message.all(@authenticated_user)
        end

        app.post '/messages' do
          message = params[:message]
          message.select { |attr, val| WRITEABLE_MESSAGE_ATTRIBUTES.include?(attr) }
          message[:from] = @authenticated_user[:id]
          message[:sent_at] = Time.now
          message[:metadata] = {}
          json Message.create(message)
        end

        app.get '/sent' do
          json Message.sent(@authenticated_user)
        end
      end
    end
  end

  register WarmGum::Base
end
