require 'sinatra/base'
require 'sinatra/json'

module Sinatra
  module WarmGum
    module Base

      def self.registered(app)

        app.get '/user' do
          json @authenticated_user.as_json
        end

        app.get %r{^/messages/(#{ID_FORMAT})$} do |message_id|
          @message = Message.find(message_id)
          message_json @message
        end

        app.get '/messages' do
          @messages = Message.all_for_user(@authenticated_user.id)
          message_json @messages
        end

        app.post '/messages' do
          halt 400, json('error' => 'message parameter required') unless params.has_key?('message')
          @message = Message.new(params['message'])
          @message.from = @authenticated_user.id
          if @message.save
            message_json @message
          else
            halt 400, json('error' => 'subject is required')
          end
        end

        app.put %r{^/messages/(#{ID_FORMAT})$} do |message_id|
          halt 400, json('error' => 'message parameter required') unless params.has_key?('message')
          @message = Message.find(message_id)
          if @message.update_attributes(params['message'])
            message_json @message
          else
            halt 400, json('error' => 'there was an error updating the message')
          end
        end

        app.get '/inbox' do
          @messages = Message.all
          message_json @messages
        end

        app.get '/sent' do
          @messages = Message.sent(@authenticated_user.id)
          message_json @messages
        end

        app.get '/drafts' do
          @messages = Message.drafts(@authenticated_user.id)
          message_json @messages
        end

        app.put '/messages/:id/deliver' do
          @message = Message.find(params[:id])
          if @message.delivered?
            halt
          else
            @message.deliver
            message_json @message
          end
        end

      end

    end
  end
end
