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
end
