module Sinatra
  module WarmGum
    module ExtensionMetadata
      def self.included(base)
        class << base
          attr_reader :extension_metadata, :metadata_transformations
        end
        base.instance_variable_set('@extension_metadata', {})
        base.instance_variable_set('@metadata_transformations', [])
        base.extend ClassMethods
      end

      module ClassMethods
        def register_extension_metadata(extension_metadata)
          @extension_metadata.merge!(extension_metadata)
        end

        def metadata_transform(&transform)
          @metadata_transformations << transform
        end
      end
    end
  end
end
