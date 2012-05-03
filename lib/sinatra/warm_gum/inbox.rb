require 'sinatra/base'

module Sinatra
  module WarmGum
    module Inbox
      def self.registered(app)

        app.get '/inbox' do
          Message.inbox(@authenticated_user[:id])
        end

        app.get '/archived' do
          Message.archived_by_user(@authenticated_user[:id])
        end

        app.put '/messages/:id/archive' do
          message = Message.find(params[:id])
          message.archive!(@authenticated_user[:id])
        end

      end
    end
  end

  register WarmGum::Inbox
end
