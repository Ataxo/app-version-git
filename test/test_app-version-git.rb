require 'helper'

class TestAppVersionGit < Test::Unit::TestCase
  should "return valid format of version" do
    @app = AppVersion.new(__FILE__)
    assert /\d\.\d.\d/  =~ @app.version
  end
  
  should "hash with commit messages" do
    @app = AppVersion.new(__FILE__)
    assert @app.changelog.is_a?(Array)
    assert @app.changelog.first.is_a?(Hash)
  end

  should "get path to git repo" do
    assert_nothing_raised do
      AppVersion.new(__FILE__)
    end
  end

  should "not get path to git repo and raise exception" do
    assert_raise ArgumentError do
      AppVersion.new(File.join(File.expand_path(__FILE__).split("/")[0..-4]))
    end
  end
end
