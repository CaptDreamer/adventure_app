require 'spec_helper'

describe "Authentication" do

  subject { page }

  describe "signin page" do
    before { visit signin_path }

    it { should have_content('Sign in') }
    it { should have_title('Sign In') }
  end

  describe "signin", :type => :feature do

    before :each do
      visit signin_path
    end

    describe "with invalid information" do
      it "displays an error" do
        click_button('Sign in')

        expect(page).to have_selector('div.alert.alert-danger',  text: 'Invalid')
        expect(page).to have_title('Sign In')
      end
    end

  	describe "with valid information" do
      let(:user) { FactoryGirl.create(:user) }
  		before do    
  			fill_in "Username",     with: user.username
        fill_in "Password",     with: user.password
        click_button('Sign in')
      end

      it "logs me in" do
        
        expect(current_path) == root_path
        expect(page).not_to have_title("Sign In")
      end

      it "has enabled admin tools" do
        expect(page).to have_content("Admin")
      end

      it "has a sign out button" do
        expect(page).to have_link("Sign out", href: signout_path)
      end

      describe "has correct links" do
        it { should have_link('List News', href: posts_path) }
        it { should have_link('New Post', href: new_post_path) }
      end

      it "and can be logged out" do
        click_link("Sign out") 
        expect(current_path) == root_path
        expect(page).not_to have_link('Sign out')
        expect(page).not_to have_content("Admin")
      end
  	end
  end
end