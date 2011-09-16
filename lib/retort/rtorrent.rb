class Retort::Rtorrent

    TYPES = {
      time: 'to_time',
      date: 'to_date',
      size: 'to_xb'
    }

    class << self

      attr_accessor :prefix, :attr_mappings, :attributes, :attributes_raw

      def setup(prefix="", &block)
        self.prefix = prefix
        self.attributes = {}
        self.attributes_raw = {}

        instance_eval(&block)
      end

      def attribute(property, options = {}, &block)
        type = options[:type]
        method_name = options[:name] || property
        method_name = "#{self.prefix}.#{method_name}" unless self.prefix.empty?
        self.attributes_raw[property] = method_name

        if TYPES.member? type
          #Syntax is 'to_*=$.....'. Example : 'to_date=$d.get_creation_date'.
          self.attributes[property] = "#{TYPES[type]}=$#{method_name}"
          property = "#{property}_raw"
        end
        self.attributes[property] = method_name
      end

      alias method_missing attribute
    end

end

