require File.join(File.dirname(__FILE__), "test_helper")

class RunGitHub
  include Appsta::GitHub
end

class TestGitHub < Test::Unit::TestCase
  context "Setting up GitHub" do
    setup do
      post = setup_base_mocks
      post.expects(:post).with(:name => "appsta", :public => false).returns("{}")
      RunGitHub.any_instance.expects(:git).with(:remote => "add origin git@github.com:github_username/appsta.git")
      RunGitHub.any_instance.expects(:git).with(:push => "origin master")
    end

    should "not fail" do
      assert true, RunGitHub.new.github
    end
  end

  context "Setting up GitHub and handling an error" do
    setup do
      post = setup_base_mocks
      post.expects(:post).with(:name => "appsta", :public => false).returns("--- \nerror: \n- error: repository creation failed\n")
    end
      
    should "raise an exception" do
      assert_raise RuntimeError do
        RunGitHub.new.github
      end
    end
  end
  
  # This sets up the mocks common to all contexts, and returns the client posting mock
  def setup_base_mocks
    RunGitHub.any_instance.expects(:ask).with("GitHub Username:").returns("github_username")
    RunGitHub.any_instance.expects(:ask).with("GitHub Password:").returns("github_password")
    client = mock("RestClient::Resource")
    RestClient::Resource.expects(:new).with("http://github.com", "github_username", "github_password").returns(client)
    post = mock("RestClient::Resource")
    client.expects(:[]).with("/api/v2/yaml/repos/create").returns(post)
    post
  end
end
