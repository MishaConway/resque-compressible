module Resque
  module Plugins
    module Compressible
      VERSION = "0.0.1"

      def before_enqueue_compressible *args
        unless compressed? args
          new_args = [{:resque_compressed => true, :payload => compressed_args(args)}]
          new_args.push 0 while new_args.size < args.size
          Resque.enqueue self, *new_args
          false
        end
      end

      def compressed? args
        args.size > 0 && args.first.kind_of?(Hash) && (args.first[:resque_compressed] || args.first['resque_compressed'])
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
          #alias_method :perform_without_compressing, :perform
          #alias_method :perform, :perform_with_compressing

          alias_method :perform, :perform_without_compressing
          alias_method :perform_with_compressing, :perform
        end
      end
    end
  end
end

