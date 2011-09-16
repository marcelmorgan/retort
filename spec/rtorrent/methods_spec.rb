require 'spec_helper'

describe Retort::Torrent do
  it "has all methods listed" do
    all_methods = Retort::Service.call("system.listMethods").to_set
    torrent_methods = Retort::Torrent.attributes_raw.values.to_set
    torrent_methods.subset?(all_methods).should == true
  end
end
