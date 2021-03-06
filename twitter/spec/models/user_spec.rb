require 'spec_helper'

describe User do
  # REFACTOR: WA: Please refator these test cases. There is a lot of duplication.
  # And also unnecessary variables.

	before do
		@user = User.new(:fullname => "Nitin Gupta", :email => "nitin@vinsol.com", :username => "nitin", :password => "12345678")
		@user.save
	end
		
	context "with its attributes empty" do
		it "should be invalid" do
			@user1 = User.new
			@user1.should_not be_valid
			@user1.should have(1).error_on(:fullname)
			@user1.should have(2).error_on(:email)						
			@user1.should have(1).error_on(:username)
			@user1.should have(1).error_on(:password)
		end
	end
	
	context "with its attributes filled" do
		it "should be valid" do
			@user1 = User.new(:fullname => "Nitin Gupta", :email => "nitin@vinsol.com", :username => "nitin1", :password => "12345678", :password_confirmation => "12345678")
			@user1.should be_valid
		end
	end
	
	context "username" do
		it "sholuld be unique" do
			@user1 = User.new(:fullname => "Nitin Gupta", :email => "nitin@vinsol.com", :username => "nitin", :password => "87654321", :password_confirmation => "87654321")
			@user1.should_not be_valid
		end
	end
	
  # TODO: WA: Remote following empty context
	context "password and password_confirmation" do 

    
    #Fixed: NG
	end
	
	context "password length" do
		it "should be greater than or equal to 8" do
			@user1 = User.new(:fullname => "Nitin Gupta", :email => "nitin@vinsol.com", :username => "nitin1", :password => "1234567", :password_confirmation => "123456789")
			@user1.should_not be_valid
			
			@user1.password = "12345678"
			@user1.password_confirmation = "12345678"
			@user1.should be_valid
			
			@user1.password = "1234567890"
			@user1.password_confirmation = "1234567890"
			@user1.should be_valid
		end
	end
	
	context "email with correct format" do
		it "should be valid" do
			@user1 = User.new(:fullname => "Nitin Gupta", :email => "nitin@vinsol.com", :username => "nitin1", :password => "123456789", :password_confirmation => "123456789")
			@user1.should be_valid
			
			@user1.email = "nitin@and"
			@user1.should_not be_valid
			
			@user1.email = "nitin.and"
			@user1.should_not be_valid			
		end
	end
	
	it "should show user profile by having username in url" do
		@user = User.new(:fullname => "Puneet Sharma", :email => "puneet@abc.com", :username => "puneet", :password => "12345678")
		@user.save
		
		@user.to_param.should == "puneet"
	end
end
