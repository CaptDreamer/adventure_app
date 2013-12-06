require 'spec_helper'

describe "StaticPages" do
  
  subject { page }

  describe "Home Page" do
    let(:user) { FactoryGirl.create(:user) }
    let!(:m1) { FactoryGirl.create(:post, user: user, title: "Example One", content: "Foo") }
    let!(:m2) { FactoryGirl.create(:post, user: user, title: "Example Two", content: "Bar") }
  	before { visit root_path }
    it { should have_content("Adventure|Byte Games") }
    it { should have_title("Adventure|Byte Games") }
    it { should_not have_title("Home") }
    it { should have_link("Company", href: company_path) }
    it { should have_link("Games", href: games_path) }
    it { should have_link("Adventure|Byte", href: root_path) }
    it { should_not have_content("Admin") }

    describe "News" do

      it { should have_content(user.first_name) }
      it { should have_content(m1.title) }
      it { should have_content(m1.content) }
      it { should have_content(m2.title) }
      it { should have_content(m2.content) }
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
