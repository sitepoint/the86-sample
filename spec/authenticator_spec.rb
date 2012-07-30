require "authenticator"

describe Authenticator do

  let(:auth) { Authenticator.new(session) }
  subject { auth }

  context "signed in" do
    let(:session) { { user_id: 100 } }
    let(:user) { double }
    let(:user_finder) { double }

    describe "#current_user and #current_user?" do
      before do
        auth.user_finder = user_finder
        user_finder.should_receive(:call).with(100).and_return(user)
      end
      its(:current_user?) { should == true }
      its(:current_user) { should == user }
    end
    describe "#sign_out" do
      it "removes the user from the session" do
        expect { auth.sign_out }.to change { session }.to({})
      end
    end
  end

  context "signed out" do
    let(:session) { {} }
    its(:current_user?) { should == false }
    describe "#current_user" do
      it "raises Authenticator::NoUser" do
        ->{ auth.current_user }.should raise_error(Authenticator::NoUser)
      end
    end
    describe "#sign_in" do
      it "adds the user_id to the session" do
        user = double(id: 2468)
        auth.sign_in(user)
        session[:user_id].should == 2468
      end
    end
  end

end
