# -*- encoding : utf-8 -*-

require 'rubygems'
require 'git'

class AppVersion
  def initialize path
    @git = Git.open(get_path path)
  end
  
  def get_path path
    path = File.expand_path(File.dirname(path))
    path = path.split("/")
    while path.size > 0
      if File.exists?(File.join(path, ".git"))
        return File.join(path)
      else
        path = path[0..-2]
      end
    end
    raise ArgumentError, "Git repository couldn't be found in your path"
  end

  def version
    log_count = @git.log(99999).size
    patch = log_count % 10
    minor = log_count/10 % 10
    major = log_count/100 % 10
    "#{major}.#{minor}.#{patch}"
  end
  
  def changelog count = 40
    @git.log(count).collect{|l|
        { :date => l.date, :author => l.committer.name, :message => l.message  }
      }
  end
  
end