module Retort

  class Exception; end

  class Torrent < Rtorrent

    setup :d do
      info_hash           name: 'hash'
      name_t                name: 'name'
      connection_current
      size                name: 'size_bytes',       type: :size
      completed           name: 'completed_bytes',  type: :size
      creation_date       name: 'creation_date',    type: :date
      downloaded          name: 'bytes_done',       type: :size
      up_rate             name: 'up.rate',          type: :size
      down_rate           name: 'down.rate',        type: :size
      message             name: 'get_message'
      bytes_left          name: 'get_left_bytes',   type: :size
      seeders             name: 'peers_complete'
      leechers            name: 'peers_connected'
      state
      complete            name: :complete,          type: :bool
      is_active           name: :active,            type: :bool
      is_hash_checked     name: :hash_checked,      type: :bool
      is_hash_checking    name: :hash_checking,     type: :bool
      is_multi_file       name: :multi_file,        type: :bool
      is_open             name: :open,              type: :bool
    end

    class << self

      def all(view="main")
        methods = attributes.map {|key,value| "#{value}="}
        Service.call("d.multicall", view, *methods).map do |r|
          attributes = Hash[self.attributes.keys.zip(r)]
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

    attr_accessor *(attributes.keys)

    def initialize(attributes)
      attributes.each do |attrib, value|
        variable = "@#{attrib}".to_sym
        self.instance_variable_set variable, value
        if attrib =~ /is_/
          bool_value = value.truth
          variable = "@#{attrib.to_s.gsub(/is_/, "")}".to_sym
          self.instance_variable_set variable, bool_value
        end
      end

    end

    #
    # Displays the estimated time remaining for download of a torrent
    # based on the download speed and bytes remaining in the format
    # hh:mm:ss
    #
    def eta
      return "--:--:--" unless self.down_rate_raw > 0
      seconds = (self.bytes_left_raw / self.down_rate_raw.to_f)
      "%02d:%02d:%02d" % [(seconds/60/60), ((seconds/60) % 60), (seconds % 60)]
    end

    def percent_completed
      self.completed_ratio.percent
    end

    def completed_ratio
      self.completed_raw/(self.size_raw.to_f)
    end

    def status
      return "complete" if @complete.truth
    end

    def actions
      actions = []

      actions << (@state.truth ? :stop : :start)
      #actions << :check_hash unless @hash_checking
      actions << (@open ? :close : :open)

      unless @complete.truth
        actions << (@active ? :pause : :resume)
      end

      actions << :erase

      actions
    end
  end
end

