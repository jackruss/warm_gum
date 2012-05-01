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
          json Message.create(message)
        end

        app.get '/sent' do
          json Message.by_from(:from => @authenticated_user[:id])
        end

      end
    end
  end

  register WarmGum::Base
end
