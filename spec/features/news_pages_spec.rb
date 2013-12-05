require 'spec_helper'

describe "News Pages" do

  subject { page }

  let(:user) { FactoryGirl.create(:user) }
  let!(:post) { FactoryGirl.create(:post, user: user, content: "Foo") }

  describe "New post page" do
  	before { visit newpost_path }

  	it { should have_content('New Post') }
  	it { should have_title('New Post') }
  end

  describe "Show Post page" do
  	before { visit post_path(post)}
  	it { should have_content(post.title) }
  	it { should have_content(post.content) }
  	it { should have_content(post.user.first_name) }
  	it { should have_content(post.created_at) }
  end

end
