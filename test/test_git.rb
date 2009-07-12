require File.join(File.dirname(__FILE__), "test_helper")

class RunGit
  include Appsta::Git
end

class TestGit < Test::Unit::TestCase
  context "Setting up Git repo" do
    setup do
      setup_base_mocks
      RunGit.any_instance.expects(:git).with(:commit => "-a -m 'initial commit by Appsta'")
    end

    should "not fail" do
      assert true, RunGit.new.git_setup
    end
  end

  context "Setting up Git repo with a custom commit message" do
    CUSTOM_MESSAGE = "my test commit message"
    
    setup do
      setup_base_mocks
      RunGit.any_instance.expects(:git).with(:commit => "-a -m '#{CUSTOM_MESSAGE}'")
    end

    should "not fail" do
      assert true, RunGit.new.git_setup(CUSTOM_MESSAGE)
    end
  end
  
  # This sets up the mocks common to all contexts
  def setup_base_mocks
    RunGit.any_instance.expects(:git).with(:init)
    RunGit.any_instance.expects(:git).with(:add => ".")
  end
end
