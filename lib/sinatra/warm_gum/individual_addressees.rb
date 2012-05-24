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

        app.put %r{^/messages/(#{ID_FORMAT})/addressees/individuals/(\d+)$} do |message_id, individual_id|
          @message = Message.find(message_id)
          if @authenticated_user.can_read_individual?(individual_id)
            @message.add_individual_addressee(individual_id)
            message_json @message
          else
            halt 403, json('error' => 'Forbidden')
          end
        end

        app.get %r{^/messages/(#{ID_FORMAT})/addressees/individuals$} do |message_id|
          @message = Message.find(message_id)
          @individuals = @authenticated_user.find_individuals_by_ids(@message.individual_addressees)
          json(:users => @individuals)
        end

        app.delete %r{^/messages/(#{ID_FORMAT})/addressees/individuals/(\d+)$} do |message_id, individual_id|
          @message = Message.find(message_id)
          if @message.individual_addressee_exists?(individual_id)
            @message.remove_individual_addressee(individual_id)
            message_json @message
          else
            halt 400, json('error' => 'Addressee does not exist')
          end
        end

      end
    end
  end
end
