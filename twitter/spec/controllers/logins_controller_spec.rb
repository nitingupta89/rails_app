require 'spec_helper'

describe LoginsController, :type => :controller do
	render_views
	
	before(:each) do
		@user = mock_model('User', {:fullname => "Nitin Gupta", :email => "nitin@vinsol.com", :username => 'nitin', :password => 'abcdefghi'})
	end
		
	it "shows login page when index is called" do
		get :index
		response.should be_success
	end
	
	it "authenticates user when login is called" do
		User.stub!(:find_by_username).and_return @user
		@user.stub!(:authenticate).with(@user.password).and_return true
		post :login, :username => @user.username, :password => @user.password
		session[:current_user_id].should_not be_nil
		flash[:notice].should eq("You have logged in successfully!")
		response.should redirect_to(tweets_path)		
	end
	
	it "on unsuccessful login to redirects to login page" do
		post :login, :username => @user.username
		flash[:notice].should eq("username or password is incorrect!")
		response.should redirect_to(logins_path)		
	end
	
	it "destroys session when logout is called" do
		controller.stub!(:only_when_user_is_logged_in).and_return true
		post :logout
		session[:current_user_id].should be_nil
		session[:current_user].should be_nil
		response.should redirect_to(login_path)
	end
end
