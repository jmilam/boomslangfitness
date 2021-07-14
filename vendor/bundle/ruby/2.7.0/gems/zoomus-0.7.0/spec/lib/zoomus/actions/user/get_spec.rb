require 'spec_helper'

describe Zoomus::Actions::User do

  before :all do
    @zc = zoomus_client
    @args = {:id => "ufR9342pRyf8ePFN92dttQ"}
  end

  describe "#user_get action" do
    before :each do
      stub_request(:post, zoomus_url("/user/get")).to_return(:body => json_response("user_get"))
    end

    it "requires id param" do
      expect{@zc.user_get(filter_key(@args, :id))}.to raise_error(ArgumentError)
    end

    it "returns a hash" do
      expect(@zc.user_get(@args)).to be_kind_of(Hash)
    end

    it "returns same params" do
      res = @zc.user_get(@args)

      expect(res["id"]).to eq(@args[:id])
      expect(res).to have_key("first_name")
      expect(res).to have_key("last_name")
      expect(res).to have_key("email")
      expect(res).to have_key("type")
    end
  end

  describe "#user_get! action" do
    before :each do
      stub_request(
        :post,
        zoomus_url("/user/get")
      ).to_return(:body => json_response("error"))
    end

    it "raises Zoomus::Error exception" do
      expect {
        @zc.user_get!(@args)
      }.to raise_error(Zoomus::Error)
    end
  end
end
