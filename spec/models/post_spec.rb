require 'spec_helper'

describe Post do
  let (:user) { FactoryGirl.create(:user) }
  before { @post = user.posts.build(title: "Example", content: "Lorem ipsum") }

  subject { @post }

  it { should respond_to(:title) }
  it { should respond_to(:content) }
  it { should respond_to(:user_id) }
  it { should respond_to(:user) }
  it { expect(@post.user).to eq user }

  it { should be_valid }

  describe "when the title is not present" do
  	before { @post.title = "" }
  	it { should_not be_valid }
  end

  describe "when the content is not present" do
  	before { @post.content = "" }
  	it { should_not be_valid }
  end

  describe "when the user is not present" do
  	before { @post.user_id = "" }
  	it { should_not be_valid }
  end

end
