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
end
