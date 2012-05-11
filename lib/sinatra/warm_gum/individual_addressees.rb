require 'sinatra/base'

module Sinatra
  module WarmGum
    module IndividualAddressees
      EXTENSION_METADATA = { 'addressees' => { 'individual' => [] } }
      METADATA_TRANSFORM = Proc.new do |message, options|
        { 'individual_addressees' => message.individual_addressees }
      end

      def self.registered(app)

        Message.register_extension_metadata(EXTENSION_METADATA)

        app.put %r{^/messages/(#{ID_FORMAT})/addressees/individual/(\d+)$} do |message_id, individual_addressee_id|
          if can_read_individual?(individual_addressee_id)
            @message = Message.find(message_id)
            @message.add_individual_addressee(individual_addressee_id)
            message_json @message
          else
            halt 403, 'Forbidden'
          end
        end

        app.delete %r{^/messages/(#{ID_FORMAT})/addressees/individual/(\d+)$} do |message_id, individual_addressee_id|
          if can_read_individual?(individual_addressee_id)
            @message = Message.find(message_id)
            @message.remove_individual_addressee(individual_addressee_id)
            message_json @message
          else
            halt 403, 'Forbidden'
          end
        end

      end
    end
  end
end
