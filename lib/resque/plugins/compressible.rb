module Resque
  module Plugins
    module Compressible
      VERSION = "0.0.1"

      def before_enqueue_compressible *args
        unless compressed?
          Resque.enqueue self, {:compressed => true, :payload => compressed_args(args)}
          false
        end
      end

      def compressed? args
        1 == args.size && args.first.kind_of?(Hash) && (args.first[:compressed] || args.first['compressed'])
      end

      def perform_with_compressing *args
        if compressed? args
          perform_without_compressing *uncompressed_args(args.first[:payload] || args.first['payload'])
        else
          perform_without_compressing *args
        end
      end

      def compressed_args args
        Base64.encode64 Zlib::Deflate.deflate(args.to_json)
      end

      def uncompressed_args data
        JSON.parse Zlib::Inflate.inflate(Base64.decode64(data))
      end

      def self.included(base)
        base.class_eval do
          alias_method :perform_without_compressing, :perform
          alias_method :perform, :perform_with_compressing
        end
      end
    end
  end
end
