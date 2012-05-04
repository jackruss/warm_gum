module Sinatra
  module WarmGum
    module ExtensionMetadata
      def self.included(base)
        class << base
          attr_reader :extension_metadata
        end
        base.instance_variable_set("@extension_metadata", {})
        base.extend ClassMethods
      end

      module ClassMethods
        def register_extension_metadata(extension_metadata)
          @extension_metadata.merge!(extension_metadata)
        end
      end
    end
  end
end
