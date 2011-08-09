require 'spec_helper'

describe WelcomeController do

  describe "GET 'index'" do
    it "should be successful" do
      get 'index'
      response.should be_success
    end
  end
  
  describe "GET 'termsofuse'" do
    it "should be successful" do
      request.path = '/termsofuse'
      get 'static'
      response.should_not redirect_to( :root )
      response.should be_success
    end
  end

  describe "GET 'privacypolicy'" do
    it "should be successful" do
      request.path = '/privacypolicy'
      get 'static'
      response.should_not redirect_to( :root )
      response.should be_success
    end
  end

  describe "GET non existing page" do
    it "should be failed" do
      request.path = '/somepage'
      get 'static'
      response.should redirect_to( :root )
    end
  end

end