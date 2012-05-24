require 'sinatra/base'

module Sinatra
  module WarmGum
    module GroupAddressees
      METADATA_TRANSFORM = Proc.new do |message, options|
        { 'group_addressees' => message.group_addressees }
      end

      def self.registered(app)
        groups_metadata_defaults = GROUPS.inject({}) { |result, group| result.merge!(group => []) }
        extension_metadata = { 'addressees' => { 'group' => groups_metadata_defaults } }
        Message.register_extension_metadata(extension_metadata)

        app.put %r{^/messages/(#{ID_FORMAT})/addressees/groups/(.*)/(\d+)$} do |message_id, group_type, group_addressee_id|
          halt 400, json('error' => 'Group type does not exist') unless group_type_exists?(group_type)

          if can_read_group?(@authenticated_user, group_type, group_addressee_id)
            @message = Message.find(message_id)
            @message.add_group_addressee(group_type, group_addressee_id)
            message_json @message
          else
            halt 403, json('error' => 'Forbidden')
          end
        end

        app.get %r{^/messages/(#{ID_FORMAT})/addressees/groups/(.*)$} do |message_id, group_type|
          halt 400, json('error' => 'Group type does not exist') unless group_type_exists?(group_type)

          @message = Message.find(message_id)
          @groups = fetch_groups(@authenticated_user, group_type, @message.group_addressees(group_type))
          json(:group_type => { :name => group_type, :groups => @groups })
        end

        app.delete %r{^/messages/(#{ID_FORMAT})/addressees/groups/(.*)/(\d+)$} do |message_id, group_type, group_addressee_id|
          halt 400, json('error' => 'Group type does not exist') unless group_type_exists?(group_type)

          if can_read_group?(@authenticated_user, group_type, group_addressee_id)
            @message = Message.find(message_id)
            @message.remove_group_addressee(group_type, group_addressee_id)
            message_json @message
          else
            halt 403, json('error' => 'Forbidden')
          end
        end

      end
    end
  end
end
