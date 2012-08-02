module Sinatra
  module WarmGum
    module GroupAddressees
      METADATA_TRANSFORM = Proc.new do |message, options|
        { 'group_addressees' => message.group_addressees }
      end
      def self.register_extension_metadata(groups)
        groups_metadata_defaults            = groups.inject({}) { |result, group| result.merge!(group => []) }
        group_individuals_metadata_defaults = groups.inject({}) { |result, group| result.merge!(group => {}) }
        extension_metadata = {
          'addressees' => {
            'group'             => groups_metadata_defaults,
            'group_individuals' => group_individuals_metadata_defaults,
          }
        }
        Message.register_extension_metadata(extension_metadata)
      end

      def self.registered(app)
        GroupAddressees::register_extension_metadata(app.settings.groups)

        app.put %r{^/messages/(#{app.settings.id_format})/addressees/groups/(.*)/(\d+)$} do |message_id, group_type, group_addressee_id|
          halt 400, app.settings.errors[286] unless group_type_exists?(group_type)
          halt 403, app.settings.errors[287] unless can_read_group?(@authenticated_user, group_type, group_addressee_id)

          @message.add_group_addressee!(group_type, group_addressee_id)
          message_json @message
        end

        app.get %r{^/messages/(#{app.settings.id_format})/addressees/groups/(.*)$} do |message_id, group_type|
          halt 400, app.settings.errors[286] unless group_type_exists?(group_type)

          @groups = fetch_groups(@authenticated_user, group_type, @message.group_addressees(group_type))
          json(:group_type => { :name => group_type, :groups => @groups })
        end

        app.delete %r{^/messages/(#{app.settings.id_format})/addressees/groups/(.*)/(\d+)$} do |message_id, group_type, group_addressee_id|
          halt 400, app.settings.errors[286] unless group_type_exists?(group_type)
          halt 403, app.settings.errors[287] unless can_read_group?(@authenticated_user, group_type, group_addressee_id)

          @message.remove_group_addressee!(group_type, group_addressee_id)
          message_json @message
        end

      end
    end
  end
end
