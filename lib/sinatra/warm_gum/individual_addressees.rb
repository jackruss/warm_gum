module Sinatra
  module WarmGum
    module IndividualAddressees
      EXTENSION_METADATA = { 'addressees' => { 'individual' => [] } }
      METADATA_TRANSFORM = Proc.new do |message, options|
        { 'individual_addressees' => message.individual_addressees }
      end

      def self.registered(app)

        Message.register_extension_metadata(EXTENSION_METADATA)

        app.put %r{^/messages/(#{app.settings.id_format})/addressees/individuals/(\d+)$} do |message_id, individual_id|
          halt 403, app.settings.errors[288] unless @authenticated_user.can_read_individual?(individual_id)

          @message.add_individual_addressee!(individual_id)
          message_json @message
        end

        app.get %r{^/messages/(#{app.settings.id_format})/addressees/individuals$} do |message_id|
          @individuals = @authenticated_user.find_individuals_by_ids(@message.individual_addressees)
          json(:users => @individuals)
        end

        app.delete %r{^/messages/(#{app.settings.id_format})/addressees/individuals/(\d+)$} do |message_id, individual_id|
          halt 404, app.settings.errors[289] unless @message.individual_addressee_exists?(individual_id)

          @message.remove_individual_addressee!(individual_id)
          message_json @message
        end

      end
    end
  end
end
