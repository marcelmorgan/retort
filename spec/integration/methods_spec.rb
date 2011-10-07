require 'spec_helper'

describe Retort::Torrent do
  it "is the correct library version" do
    client_version = Retort::Service.call "system.client_version"
    client_version.should == "0.8.9"

    library_version = Retort::Service.call("system.library_version")
    library_version.should == "0.12.9"
  end

  it "has all methods listed" do
    all_methods = Retort::Service.call("system.listMethods").to_set
    torrent_methods = Retort::Torrent.attributes_raw.values.to_set
    torrent_methods.subset?(all_methods).should == true
  end

  it "has all methods listed" do
    all_methods = Retort::Service.call("system.listMethods").to_set
    torrent_methods = Retort::Torrent.attributes_raw.values.to_set
    torrent_methods.subset?(all_methods).should == true
  end
end
