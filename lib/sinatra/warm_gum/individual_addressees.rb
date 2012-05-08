require 'sinatra/base'

module Sinatra
  module WarmGum
    module IndividualAddressees
      EXTENSION_METADATA = { :addressees => { :individual => [] } }

      def self.registered(app)

        Message.register_extension_metadata(EXTENSION_METADATA)
        Message.metadata_transform do
          json_extensions.merge!(:individual_addressees => message.metadata.addressees.individual)
        end

        app.get '/messages/:id/addressees/individuals' do
          message = Message.find(params[:id])
          json User.find(message.individual_addressess)
        end

        app.post '/messages/:id/addressees/individuals' do
          message = Message.find(params[:id])
          message.add_individual_addressee(params[:individual_addressee])
          json message
        end

        app.delete '/messages/:id/addressees/individuals/:individual_addressee_id' do
          message = Message.find(params[:id])
          message.add_individual_addressee(params[:individual_addressee])
          json message
        end

      end
    end
  end
end
