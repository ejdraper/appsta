require File.join(File.dirname(__FILE__), "test_helper")

class RunJQuery
  include Appsta::JQuery
end

class TestJQuery < Test::Unit::TestCase
  context "Switching to jQuery" do
    setup do
      RunJQuery.any_instance.expects(:run).with("rm -f public/javascripts/*")
    end

    should "not fail" do
      RunJQuery.any_instance.expects(:run).with("curl -s -L http://jqueryjs.googlecode.com/files/jquery-1.3.2.min.js > public/javascripts/jquery.js")
      assert true, RunJQuery.new.use_jquery
    end

    should "not fail for a specific version of jQuery" do
      RunJQuery.any_instance.expects(:run).with("curl -s -L http://jqueryjs.googlecode.com/files/jquery-1.3.3.min.js > public/javascripts/jquery.js")
      assert true, RunJQuery.new.use_jquery("1.3.3")
    end
  end
end
