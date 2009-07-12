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
      assert true, RunHeroku.new.heroku
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
      assert true, RunHeroku.new.heroku(:test)
    end
  end
  
  # This sets up the base mocks common to all contexts, and returns the client mock
  def setup_base_mocks
    client = mock("Heroku::Client")
    Heroku::Client.expects(:new).with("heroku_username", "heroku_password").returns(client)
    client
  end
end
