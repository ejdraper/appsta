require File.join(File.dirname(__FILE__), "test_helper")

class RunDefaultFiles
  include Appsta::DefaultFiles
end

class TestGit < Test::Unit::TestCase
  context "Removing default files" do
    setup do
      RunDefaultFiles.any_instance.expects(:run).with("rm -f README")
      RunDefaultFiles.any_instance.expects(:run).with("rm -f public/index.html")
      RunDefaultFiles.any_instance.expects(:run).with("rm -f public/favicon.ico")
    end

    should "not fail" do
      assert true, RunDefaultFiles.new.remove_default_files
    end
  end
end
