module Retort 
	class Torrent
		def self.attr_mappings 
			{
				info_hash: 					'd.hash',
				name: 							'd.name',
				connection_current: 'd.connection_current',
				size_bytes: 				'd.size_bytes',
				completed_bytes:		'd.completed_bytes',
				creation_date: 			'd.creation_date',
				bytes_done: 				'd.bytes_done',
				up_rate: 						'd.up.rate',
				down_rate: 					'd.down.rate',
				seeders:						'd.peers_complete',
				leechers: 					'd.peers_connected',
				is_completed:				'd.complete',
				is_active:					'd.is_active',
				is_hash_checked:		'd.is_hash_checked',
				is_hash_checking:		'd.is_hash_checking',
				is_multifile:				'd.is_multi_file',
				is_open:						'd.is_open'
			}
		end

		attr_accessor *(attr_mappings.keys)

		def self.setup(rpc_path)
			@@service = XMLRPC::Client.new2(rpc_path)
			@@rpc_path = rpc_path
		end

		def self.service_call(*args)
			@@service.call_async *args
		end

		def self.all(view="main")
			methods = attr_mappings.map {|key,value| "#{value}="}
			service_call("d.multicall", view, *methods).map do |r| 
				attributes = Hash[attr_mappings.keys.zip(r)]
				Torrent.new attributes
			end
		end
		
		def self.views
			@@service.call_async("view.list")
		end

		def self.load(url)
			@@service.call_async "load_start", url
		end

		def self.action(name, info_hash)
			@@service.call_async "d.#{name}", info_hash
		end

		def initialize(attributes)
			attributes.each do |attrib, value|
				 self.instance_variable_set "@#{attrib}".to_sym, value
			end
		end
	end
end

