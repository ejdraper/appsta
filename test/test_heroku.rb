require File.join(File.dirname(__FILE__), "test_helper")

class RunHeroku
  include Appsta::Heroku
end

class TestHeroku < Test::Unit::TestCase
  context "Setting up Heroku" do
    setup do
      client = setup_base_mocks
      client.expects(:create).with("appsta", {})
      RunHeroku.any_instance.expects(:git).with(:remote => "add production git@heroku.com:appsta.git")
      RunHeroku.any_instance.expects(:git).with(:push => "production master")
    end

    should "not fail and should ask for Heroku credentials first time around" do
      RunHeroku.any_instance.expects(:ask).with("Heroku Username:").returns("heroku_username")
      RunHeroku.any_instance.expects(:ask).with("Heroku Password:").returns("heroku_password")
      assert_equal "http://appsta.heroku.com - git@heroku.com:appsta.git", RunHeroku.new.heroku
    end
  end

  context "Setting up Heroku with a custom environment" do
    setup do
      client = setup_base_mocks
      client.expects(:create).with("appsta-test", {})
      RunHeroku.any_instance.expects(:git).with(:remote => "add test git@heroku.com:appsta-test.git")
      RunHeroku.any_instance.expects(:git).with(:push => "test master")
    end

    should "not fail and should not ask for Heroku credentials second time around" do
      assert_equal "http://appsta-test.heroku.com - git@heroku.com:appsta-test.git", RunHeroku.new.heroku(:test)
    end
  end
  
  # This sets up the base mocks common to all contexts, and returns the client mock
  def setup_base_mocks
    client = mock("Heroku::Client")
    Heroku::Client.expects(:new).with("heroku_username", "heroku_password").returns(client)
    client
  end

  context "Setting up Heroku gems manifest" do
    setup do
      @gems = [{:name => "hpricot"}, {:name => "thoughtbot-shoulda", :lib => "shoulda", :source => "http://gems.github.com"}]
      @gem_manifest =<<EOF
hpricot
thoughtbot-shoulda --source http://gems.github.com
EOF
    end
    
    should "create a valid gem manifest file" do
      RunHeroku.any_instance.stubs(:gem)
      RunHeroku.any_instance.expects(:file).with(".gems", @gem_manifest)
      RunHeroku.new.heroku_gems(@gems)
    end

    should "handle calls to install the gems" do
      RunHeroku.any_instance.stubs(:file)
      RunHeroku.any_instance.expects(:gem).with("hpricot", {})
      RunHeroku.any_instance.expects(:gem).with("thoughtbot-shoulda", {:lib => "shoulda", :source => "http://gems.github.com"})
      RunHeroku.new.heroku_gems(@gems)
    end
  end
end
