module Sinatra
  module WarmGum
    module Base

      def self.registered(app)

        app.get '/user' do
          json @authenticated_user.as_json
        end

        app.get %r{^/messages/(#{app.settings.id_format})$} do |message_id|
          message_json @message
        end

        app.get '/messages' do
          @messages = Message.all_for_user(@authenticated_user.id)
          message_json @messages.page(params[:page]).per(settings.per_page)
        end

        app.post '/messages' do
          @message = Message.new(params['message'])
          @message.from = @authenticated_user.id
          if @message.save
            message_json @message
          else
            halt 400, settings.errors[282].to_json
          end
        end

        app.put %r{^/messages/(#{app.settings.id_format})$} do |message_id|
          halt 403, settings.errors[284].to_json if @message.delivered?

          if @message.update_attributes(params['message'])
            message_json @message
          else
            halt 400, settings.errors[282].to_json
          end
        end

        app.get '/sent' do
          @messages = Message.sent(@authenticated_user.id)
          message_json @messages.page(params[:page]).per(settings.per_page)
        end

        app.get '/drafts' do
          @messages = Message.drafts(@authenticated_user.id)
          message_json @messages.page(params[:page]).per(settings.per_page)
        end

        app.put %r{^/messages/(#{app.settings.id_format})/deliver$} do |message_id|
          halt 400, settings.errors[283].to_json if @message.delivered?

          if @message.deliver!
            message_json @message
          else
            halt 400, settings.errors[283].to_json
          end
        end

      end

    end
  end
end
