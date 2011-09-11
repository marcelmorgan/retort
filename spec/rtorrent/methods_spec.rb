require 'spec_helper'

describe Retort::Torrent do
  it "has all methods listed" do
    all_methods = Retort::Service.call "system.listMethods"
    torrent_methods = Retort::Torrent.attr_mappings.values.reject {|x| x =~ /\$/}
    x = torrent_methods.reject {|m| all_methods.include?(m)}
    x.size.should == 0
  end
end
