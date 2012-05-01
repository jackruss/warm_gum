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
          json Message.find(params[:id])
        end

        app.get '/messages' do
          json([{
            :message => {
              :id => 1234,
              :sent_at => "2012/04/23",
              :subject => "Get ready for messaging v2",
              :from => 2,
              :body => "this is a hot body.",
              :metadata => {}
            }
          }])
        end

        app.post '/messages' do
          json Message.create!(params[:message])
        end

        app.get '/sent' do
          json([{
            :message => {
              :id => 1234,
              :sent_at => "2012/04/23",
              :subject => "Get ready for messaging v2",
              :from => 2,
              :body => "this is a hot body.",
              :metadata => {}
            }
          }])
        end
      end
    end
  end

  register WarmGum::Base
end
