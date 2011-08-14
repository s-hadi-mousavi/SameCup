module Db
  class Initializer
    def self.prime!
      social_app  = Factory(:project, :name => "Social App")
      banking_app = Factory(:project, :name => "Banking App")
    end
  end
end
