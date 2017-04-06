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

      def perform args
        if compressed? args
          perform_ex *uncompressed_args(args)
        else
          peform_ex *args
        end
      end

      def compressed_args args
        Base64.encode64 Zlib::Deflate.deflate(args.to_json)
      end

      def uncompressed_args data
        JSON.parse Zlib::Inflate.inflate(Base64.decode64(data))
      end
    end
  end
end