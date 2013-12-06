require 'spec_helper'

describe "News Pages" do

  subject { page }

  let(:user) { FactoryGirl.create(:user) }
  before { sign_in user }

  describe "New post page" do

    before {visit new_post_path}  
    
    it { should have_content('New post') }
    it { should have_title('New Post') }

    describe "form not filled out" do
      before { click_button "Post" }

      it { should have_title('New Post') }
      it { should have_selector('div.alert.alert-danger', text: 'error') }
    end

    describe "form correctly filled out" do
      before do
        fill_in "Title",    with: "Example"
        fill_in "Content",  with: "Lorem Ipsum"
        click_button "Post"
      end

      it { should have_selector('div.alert.alert-success', text: 'created') }
      it { current_url == root_url }
      it { should have_content('Example') }
      it { should have_content('Lorem Ipsum') }
    end
  end

  describe "Edit Posts" do
    let(:post) { FactoryGirl.create(:post) }

    describe "page" do
      before { visit edit_post_path(post) }

      it { should have_content('Edit post') }
      it { should have_title('Edit Post') }

      describe "form not filled out" do
        before do 
          fill_in "Title",    with: ""
          fill_in "Content",  with: ""
          click_button "Submit Changes" 
        end

        it { should have_title('Edit Post') }
        it { should have_selector('div.alert.alert-danger', text: 'error') }
      end

      describe "form correctly filled out" do
        before do
          fill_in "Title",    with: "Example Update"
          fill_in "Content",  with: "Ipsum Lorem"
          click_button "Submit Changes"
        end

        it { should have_selector('div.alert.alert-success', text: 'updated') }
        it { should have_content('Example Update') }
        it { should have_content('Ipsum Lorem') }
        it { current_url == root_url }
      end
    end
  end
end