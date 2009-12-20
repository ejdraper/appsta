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

  context "Pushing Git" do
    should "not fail to a single remote" do
      RunGit.any_instance.expects(:git).with(:push => "origin master")
      assert true, RunGit.new.git_push(:origin)
    end

    should "not fail to multiple remotes" do
      RunGit.any_instance.expects(:git).with(:push => "origin master")
      RunGit.any_instance.expects(:git).with(:push => "staging master")
      RunGit.any_instance.expects(:git).with(:push => "production master")
      assert true, RunGit.new.git_push(:origin, :staging, :production)
    end
  end
  
  # This sets up the mocks common to all contexts
  def setup_base_mocks
    RunGit.any_instance.expects(:git).with(:init)
    RunGit.any_instance.expects(:git).with(:add => ".")
  end
end
