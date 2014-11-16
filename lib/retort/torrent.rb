module Retort

  class Exception; end

  class Torrent < Rtorrent

    setup :d do
      info_hash           name: 'hash'
      torrent_name        name: 'name'
      connection_current
      size                name: 'size_bytes',       type: :size
      completed           name: 'completed_bytes',  type: :size
      creation_date       name: 'creation_date',    type: :date
      downloaded          name: 'bytes_done',       type: :size
      up_rate             name: 'up.rate',          type: :size
      down_rate           name: 'down.rate',        type: :size
      message             name: 'get_message'
      seeders             name: 'peers_complete'
      leechers            name: 'peers_connected'
      state
      complete
      is_active
      is_hash_checked
      is_hash_checking
      is_multi_file
      is_open
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
    def files
      File.all(self.info_hash)
    end
    def commit_priorities
      Service.call("d.update_priorities",self.info_hash)
    end

  end
end

