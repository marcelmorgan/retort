class Retort::Rtorrent

    TYPES = {
      time: 'to_time',
      date: 'to_date',
      size: 'to_xb'
    }

    attr_accessor :attributes, :attributes_raw

    def initialize(prefix)
      @attributes = {}
      @attributes_raw = {}
      @prefix = prefix
    end

    def attribute(property, options = {}, &block)
      type = options[:type]
      method_name = options[:name] || property
      method_name = "#{@prefix}.#{method_name}" unless @prefix.empty?
      @attributes_raw[property] = method_name

      if TYPES.member? type
        #Syntax is 'to_*=$.....'. Example : 'to_date=$d.get_creation_date'.
        @attributes[property] = "#{TYPES[type]}=$#{method_name}"
        property = "#{property}_raw"
      end
      @attributes[property] = method_name
    end

    alias method_missing attribute

    def self.build(prefix="", &block)
      c = new(prefix)
      c.instance_eval(&block)
      c.attributes
    end

end

