require 'spec_helper'

describe User do

  before { @user = User.new(first_name: "Example", last_name: "User", username:"EUser123", email: "user@example.com", password: "foobar", password_confirmation: "foobar") }

  subject { @user }

  it { should respond_to(:first_name) }
  it { should respond_to(:last_name) }
  it { should respond_to(:username) }
  it { should respond_to(:email) }
  it { should respond_to(:password_digest) }
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }
  it { should respond_to(:authenticate) }
  it { should respond_to(:remember_token) }
  it { should respond_to(:posts) }

  it { should be_valid }

  describe "when the first name is not present" do
  	before { @user.first_name = "" }
  	it { should_not be_valid }
  end

  describe "when the last name is not present" do
  	before { @user.last_name = "" }
  	it { should_not be_valid }
  end

  describe "when the username is not present" do
  	before { @user.first_name = "" }
  	it { should_not be_valid }
  end

  describe "when the username is not present" do
  	before { @user.username = "" }
  	it { should_not be_valid }
  end

  describe "when the email is not present" do
  	before { @user.email = "" }
  	it { should_not be_valid }
  end

  describe "when the first name is too long" do
  	before { @user.first_name = "a" * 11 }
  	it { should_not be_valid }
  end

  describe "when the last name is too long" do
  	before { @user.last_name = "a" * 21 }
  	it { should_not be_valid }
  end

  describe "when the username is too short" do
  	before { @user.username = "a" * 5 }
  	it { should_not be_valid }
  end

  describe "when email format is invalid" do
    it "should be invalid" do
      addresses = %w[user@foo,com user_at_foo.org example.user@foo.
                     foo@bar_baz.com foo@bar+baz.com]
      addresses.each do |invalid_address|
        @user.email = invalid_address
        expect(@user).not_to be_valid
      end
    end
  end

  describe "when email format is valid" do
    it "should be valid" do
      addresses = %w[user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
      addresses.each do |valid_address|
        @user.email = valid_address
        expect(@user).to be_valid
      end
    end
  end

  describe "email address with mixed case" do
    let(:mixed_case_email) { "Foo@ExAMPle.CoM" }

    it "should be saved as all lower-case" do
      @user.email = mixed_case_email
      @user.save
      expect(@user.reload.email).to eq mixed_case_email.downcase
    end
  end

  describe "when email address is already taken" do
    before do
      user_with_same_email = @user.dup
      user_with_same_email.email = @user.email.upcase
      user_with_same_email.username = "EUser1234"
      user_with_same_email.save
    end

    it { should_not be_valid }
  end

  describe "when username is already taken" do
  	before do
  		user_with_same_username = @user.dup
  		user_with_same_username.username = @user.username.upcase
  		user_with_same_username.email = "user123@example.com"
  		user_with_same_username.save
  	end

  	it { should_not be_valid }
  end

  describe "when the password is too short" do
  	before do
  		@user.password = "a" * 5
  		@user.password_confirmation = "a" * 5
  	end

  	it { should_not be_valid }
  end

  describe "when the password does not match confirmation" do
  	before do
  		@user.password = "foobar"
  		@user.password_confirmation = "barfoo"
  	end

  	it { should_not be_valid }
  end

  describe "when the password is not present" do
  	before do
  		@user.password = " "
  		@user.password_confirmation = " "
  	end

  	it { should_not be_valid }
  end

  describe "return value of authenticate method" do
    before { @user.save }
    let(:found_user) { User.find_by(email: @user.email) }

    describe "with valid password" do
      it { should eq found_user.authenticate(@user.password) }
    end

    describe "with invalid password" do
      let(:user_for_invalid_password) { found_user.authenticate("invalid") }

      it { should_not eq user_for_invalid_password }
      specify { expect(user_for_invalid_password) == false }
    end
  end

  describe "remember token" do
    before { @user.save }
    it { expect(@user.remember_token).not_to be_blank }
  end

  describe "micropost associations" do

    before { @user.save }
    let!(:older_post) do
      FactoryGirl.create(:post, user: @user, created_at: 1.day.ago)
    end
    let!(:newer_post) do
      FactoryGirl.create(:post, user: @user, created_at: 1.hour.ago)
    end

    it "should have the right microposts in the right order" do
      expect(@user.posts.to_a).to eq [newer_post, older_post]
    end
  end
end
