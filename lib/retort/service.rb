module Retort

  class Config
    attr_accessor :url
  end

  class Service

    class << self

      def configure
        config = Config.new
        yield config
        @@service = XMLRPC::Client.new2(config.url)
      end

      # by default, if configure hasn't been call the url will be defaulted
      # to http://localhost/RPC2
      def service
        @@service ||= XMLRPC::Client.new2("http://elijah/RPC2")
      end

      def call(*args)
        service.call_async *args
      end

    end
  end
end

