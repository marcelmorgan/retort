class Retort::Rtorrent

    TYPES = {
      time: 'to_time',
      date: 'to_date',
      size: 'to_xb'
    }

    class << self

      attr_accessor :prefix, :settings, :attr_mappings, :attributes, :attributes_raw

      def setup(prefix='', &block)
        self.prefix = prefix
        self.settings = {}

        instance_eval(&block)

        self.build_attributes
      end

      def add_setting(property, options = {}, &block)
        self.settings[property] = options
      end
      alias method_missing add_setting

      def build_attributes
        self.attributes = {}
        self.attributes_raw = {}

        self.settings.each do |property, options|

          type = options[:type]
          method_name = options[:name] || property
          method_name = "#{self.prefix}.#{method_name}" unless self.prefix.empty?
          self.attributes_raw[property] = method_name

          if TYPES.member? type
            #Syntax is 'to_*=$.....'. Example : 'to_date=$d.get_creation_date'.
            self.attributes[property] = "#{TYPES[type]}=$#{method_name}"
            property = "#{property}_raw"
          end

          if type == :bool
            define_method "#{options[:name].to_s}?" do
              bool = instance_variable_get "@#{options[:name]}"
              bool = bool.truth if bool.is_a? Fixnum
              bool
            end
          end

          self.attributes[property] = method_name
        end
      end

    end

end

