module Retort::Conversion


  class Call
    TYPES = { time: 'to_time', date: 'to_date', size: 'to_xb' }
    attr_accessor :attributes

    def initialize(prefix)
      @attributes = {}
      @prefix = prefix
    end

    def method_missing(*args, &block)
      property = args.shift
      options = args.shift || {}

      type = options[:type]
      method_name = options[:name] || property
      method_name = "#{@prefix}.#{method_name}" unless @prefix.empty?

      if TYPES.member? type
        #Syntax is 'to_*=$.....'. Example : 'to_date=$d.get_creation_date'.
        @attributes[property] = "#{TYPES[type]}=$#{method_name}"
        property = "#{property}_raw"
      end
      @attributes[property] = method_name
    end
  end

  def build(prefix="")
    c = Call.new prefix
    yield c
    c.attributes
  end

end

