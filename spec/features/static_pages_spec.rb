require 'spec_helper'

describe "StaticPages" do
  
  subject { page }

  describe "Home Page" do
  	before { visit root_path }
    it { should have_content("Adventure|Byte Games") }
    it { should have_title("Adventure|Byte Games") }
    it { should_not have_title("Home") }
    it { should have_link("Company", href: company_path) }
    it { should have_link("Games", href: games_path) }
    it { should have_link("Adventure|Byte", href: root_path) }
    it { should_not have_content("Admin") }

    describe "should correctly display news" do
      let(:user) { FactoryGirl.create(:user) }
      let!(:m1) { FactoryGirl.create(:post, user: user, content: "Foo") }
      let!(:m2) { FactoryGirl.create(:post, user: user, content: "Bar") }
      it { should have_content(user.first_name) }

      it "and the first posts info" do
        expect(page).to have_content(m1.title) 
        expect(page).to have_content(m1.content) 
      end

      it "and the secont posts info" do
        expect(page).to have_content(m2.title) 
        expect(page).to have_content(m2.content) 
      end
    end
  end

  describe "Company Page" do
  	before { visit company_path }
  	it { should have_content("Company") }
  	it { should have_title("Adventure|Byte Games - Company") }
  end

  describe "Games Page" do
  	before { visit games_path }
  	it { should have_content("Games") }
  	it { should have_title("Adventure|Byte Games - Games") }
  end
end
