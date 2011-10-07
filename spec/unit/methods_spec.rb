require 'spec_helper'

describe Retort::Torrent do
  it "creates a new torrent with attrubutes" do

    attributes = {
      :info_hash=>"810CE08C5BD1D4D15E2B6B1579D704FBAE54D58A",
      :name_t=>"archlinux-2011.08.19-core-dual.iso",
      :connection_current=>"leech",
      :size=>"673.0 MB",
      "size_raw"=>705691648,
      :completed=>"  0.0 KB",
      "completed_raw"=>0,
      :creation_date=>"19/08/2011",
      "creation_date_raw"=>1313750041,
      :downloaded=>"416.0 KB",
      "downloaded_raw"=>425984,
      :up_rate=>"  0.0 KB",
      "up_rate_raw"=>0,
      :down_rate=>"  7.4 KB",
      "down_rate_raw"=>7537,
      :message=>"",
      :bytes_left=>"673.0 MB",
      "bytes_left_raw"=>705691648,
      :seeders=>19,
      :leechers=>19,
      :state=>1,
      :complete=>0,
      :is_active=>1,
      :is_hash_checked=>1,
      :is_hash_checking=>0,
      :is_multi_file=>0,
      :is_open=>1
    }

    t = Retort::Torrent.new attributes

    t.open?.should == true
    t.active?.should == true
    t.multi_file?.should == false
    t.complete?.should == false
    t.hash_checked?.should == true
    t.hash_checking?.should == false

  end

end
