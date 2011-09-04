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

      def call(*args)
        @@service.call_async *args
      end

    end
  end
end

