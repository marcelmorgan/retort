module Retort 

  class Torrent
  
    class << self
      def attr_mappings 
        {
          info_hash:          'd.hash',
          name:               'd.name',
          connection_current: 'd.connection_current',
          size_bytes:         'd.size_bytes',
          completed_bytes:    'd.completed_bytes',
          creation_date:      'd.creation_date',
          bytes_done:         'd.bytes_done',
          up_rate:            'd.up.rate',
          down_rate:          'd.down.rate',
          seeders:            'd.peers_complete',
          leechers:           'd.peers_connected',
          is_completed:       'd.complete',
          is_active:          'd.is_active',
          is_hash_checked:    'd.is_hash_checked',
          is_hash_checking:   'd.is_hash_checking',
          is_multifile:       'd.is_multi_file',
          is_open:            'd.is_open'
        }
      end

      def all(view="main")
        methods = attr_mappings.map {|key,value| "#{value}="}
        Service.call("d.multicall", view, *methods).map do |r| 
          attributes = Hash[attr_mappings.keys.zip(r)]
          Torrent.new attributes
        end
      end
      
      def views
        Service.call "view.list"
      end

      def load(url)
        Service.call "load_start", url
      end

      def action(name, info_hash)
        Service.call "d.#{name}", info_hash
      end
    end

    attr_accessor *(attr_mappings.keys)

    def initialize(attributes)
      attributes.each do |attrib, value|
         self.instance_variable_set "@#{attrib}".to_sym, value
      end
    end
  end
end

