require 'sinatra/base'
require 'sinatra/json'

module Sinatra
  module WarmGum
    module Base

      def self.registered(app)

        app.get '/user' do
          json @authenticated_user.as_json
        end

        app.get %r{^/messages/#{ID_FORMAT}$} do
          @message = Message.find(params[:id])
          json @message.as_json
        end

        app.get '/messages' do
          @messages = Message.all_for_user(@authenticated_user.id)
          json @messages.as_json
        end

        app.post '/messages' do
          halt 400, 'message parameter required' unless params.has_key?('message')
          @message = Message.new(params['message'])
          @message.from = @authenticated_user.id
          if @message.save
            json @message.as_json
          else
            halt 400, 'subject is required'
          end
        end

        app.get '/sent' do
          @messages = Message.sent_by_user(@authenticated_user[:id])
          json @messages.as_json
        end

        app.get '/drafts' do
          @messages = Message.by_state('draft')
          json @messages.as_json
        end

        app.put '/messages/:id/deliver' do
          @message = Message.find(params[:id])
          if @message.delivered?
            halt
          else
            @message.deliver
            json @message.as_json
          end
        end

      end

    end
  end
end
