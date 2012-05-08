require 'sinatra/base'
require 'sinatra/json'

module Sinatra
  module WarmGum
    module Base

      def self.registered(app)

        app.get '/user' do
          json @authenticated_user
        end

        app.get '/messages/:id' do
          @message = Message.find(params[:id])
          if can_read?(@authenticated_user, @message)
            json @message
          else
            halt 403, 'Forbidden'
          end
        end

        app.get '/messages' do
          json Message.by_user(@authenticated_user[:id])
        end

        app.post '/messages' do
          halt 400, 'message parameter required' unless params.has_key?('message')
          message = Message.new(params['message'])
          message.from = @authenticated_user.id
          if message.save
            json message
          else
            halt 400, 'subject is required'
          end
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
