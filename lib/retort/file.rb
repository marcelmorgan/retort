module Retort
  # A file inside a torrent
  class File < Rtorrent
    setup :f do
      get_completed_chunks
      get_frozen_path
      is_created
      is_open
      get_last_touched
      get_match_depth_next
      get_match_depth_prev
      get_offset
      get_path
      get_path_components
      get_path_depth
      get_priority
      get_range_first
      get_range_second
      get_size_bytes
      get_size_chunks
    end
    def [](v)
      instance_variable_get "@#{v}".to_sym
    end
    def initialize(attributes, meta)
      @index = meta.fetch(:index)
      @torrent_info_hash = meta.fetch(:torrent_info_hash)
      @attributes = {}
      attributes.each do |attrib, value|
        variable = "@#{attrib}".to_sym
        if attrib =~ /is_/
          bool_value = value.truth
          variable = "@#{attrib.to_s.gsub(/is_/, "")}".to_sym
          self.instance_variable_set variable, bool_value
        elsif attrib =~ /get_/
          variable = "@#{attrib.to_s.gsub(/get_/, "")}".to_sym
          self.instance_variable_set variable, value
        else
          self.instance_variable_set variable, value
        end
      end

    end
    def completed?
      @completed_chunks == @size_chunks
    end

    def self.all(info_hash)
      methods = attributes.map {|key,value| "#{value}="}
      Service.call("f.multicall", info_hash,"", *methods).map.with_index do |r, index|
        attributes = Hash[self.attributes.keys.zip(r)]
        self.new attributes, {torrent_info_hash: info_hash, index: index}
      end
    end

    PRIORITY_HIGH=2
    PRIORITY_NORMAL=1

    def set_priority(prio,commit=true)
      Service.call("f.set_priority",@torrent_info_hash,@index, prio)
      Torrent.new({info_hash: @torrent_info_hash}).commit_priorities if commit
    end
  end
end


