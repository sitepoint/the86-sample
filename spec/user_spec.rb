require "spec_helper" unless ENV["NO_HELPER"]

require_relative "../app/models/user"

describe User do

  let(:session) { Hash.new }

  before do
    User.session = session
  end

  describe ".find" do
    it "finds user by ID" do
      User.create(name: "First")
      u = User.create(name: "Second")
      User.create(name: "Third")
      User.find(u.id).name.should == "Second"
    end
  end

  describe ".where" do
    before do
      session[:users] = [
        User.new(id: 2, name: "Duplicate"),
        User.new(id: 4, name: "Duplicate"),
        User.new(id: 8, name: "Eight"),
      ]
    end
    it "finds by id" do
      users = User.where(id: 8)
      users.should_not be_empty
      u = users.first
      u.id.should == 8
      u.name.should == "Eight"
    end
    it "finds by name" do
      users = User.where(name: "Duplicate")
      users.map(&:id).should == [2, 4]
      users.map(&:name).should == %w{Duplicate Duplicate}
    end
  end

  describe ".create" do
    it "creates user" do
      previous_id = User.send(:next_id)
      user = User.create(name: "Test Create")
      user.id.should == 1
      user.name.should == "Test Create"
    end
    it "increments ID" do
      3.times.map { User.create({}).id }.should == [1,2,3]
    end
  end

end
