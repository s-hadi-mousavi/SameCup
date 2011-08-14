require 'ruby-debug'
module Db
  class Initializer
    def self.prime!
      social_app  = Factory(:project, :name => "Social App")
      print '.'
      banking_app = Factory(:project, :name => "Banking App")
      print '.'

      print "\n"
    end
  end
end
