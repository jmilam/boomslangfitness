require 'spec_helper'

describe Zoomus::Actions::Meeting do

  before :all do
    @zc = zoomus_client
    @args = {:host_id => "ufR93M2pRyy8ePFN92dttq",
             :id => "252482092"}
  end

  describe "#meeting_delete action" do
    before :each do
      stub_request(
        :post,
        zoomus_url("/meeting/delete")
      ).to_return(:body => json_response("meeting_delete"))
    end

    it "requires a 'host_id' argument" do
      expect {
        @zc.meeting_delete(filter_key(@args, :host_id))
      }.to raise_error(ArgumentError)
    end

    it "requires a 'id' argument" do
      expect {
        @zc.meeting_delete(filter_key(@args, :id))
      }.to raise_error(ArgumentError)
    end

    it "returns a hash" do
      expect(@zc.meeting_delete(@args)).to be_kind_of(Hash)
    end

    it "returns id and deleted at attributes" do
      res = @zc.meeting_delete(@args)

      expect(res["id"]).to eq(@args[:id])
      expect(res["deleted_at"]).to eq("2013-04-05T15:50:47Z")
    end
  end

  describe "#meeting_delete! action" do
    before :each do
      stub_request(
        :post,
        zoomus_url("/meeting/delete")
      ).to_return(:body => json_response("error"))
    end

    it "raises Zoomus::Error exception" do
      expect {
        @zc.meeting_delete!(@args)
      }.to raise_error(Zoomus::Error)
    end
  end
end
