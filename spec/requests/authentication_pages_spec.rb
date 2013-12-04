require 'spec_helper'

describe "Authentication" do

  subject { page }

  describe "signin page" do
    before { visit signin_path }

    it { should have_content('Sign in') }
    it { should have_title('Sign In') }
  end

  describe "signin" do
  	before { visit signin_path }

  	describe "with valid information" do
  		before do        
  			fill_in "Email",    with: "example@email.com"
        	fill_in "Password", with: "foobar"
        	click_button "Sign in"
  		end

  		it { should redirect_to root_path }
  		it { should have_content("Administrator")}
  	end

  	describe "with invalid information" do
  	  before { click_button "Sign in" }

      it { should have_title('Sign in') }
      it { should have_selector('div.alert.alert-danger', text: 'Invalid') }
  	end
  end
end