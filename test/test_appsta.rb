require File.join(File.dirname(__FILE__), "test_helper")

# Dummy template runner just for the specs, so we can be sure Appsta is calling the right method
module Rails
  class TemplateRunner
  end
end

class TestAppsta < Test::Unit::TestCase
  context "Loading Appsta" do
    setup do
      Rails::TemplateRunner.expects(:send).with(:include, Appsta)
    end
    
    should "try to include the Appsta module on the Rails template runner" do
      Appsta.load
    end
  end

  context "Grabbing Appsta template path" do
    should "return the right path" do
      assert_equal File.expand_path(File.join(File.dirname(__FILE__), "..", "lib", "template.rb")), Appsta.template_path
    end
  end

  context "Grabbing Appsta resources path" do
    should "return the right path" do
      assert_equal File.expand_path(File.join(File.dirname(__FILE__), "..", "resources")), Appsta.resources_path
    end
  end
end
