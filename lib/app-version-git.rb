# -*- encoding : utf-8 -*-

require 'rubygems'
require 'git'

class AppVersion
  def initialize path
    path = File.expand_path(File.join(File.dirname(path),".."))
    @git = Git.open(path)
  end
  
  def version
    log_count = @git.log.size
    patch = log_count % 10
    minor = log_count/10 % 10
    major = log_count/100 % 10
    "#{major}.#{minor}.#{patch}"
  end
  
  def changelog
    @git.log.collect{|l|
        { :date => l.date, :author => l.committer.name, :message => l.message  }
      }
  end
  
end