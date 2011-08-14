namespace :samecup do
  namespace :dev do
    desc "Ensure non production"
    task :ensure_non_production_environment do
      raise "You can not run this in production" if Rails.env.production?
    end

    desc "Prime the database"
    task :prime => [:ensure_non_production_environment, 'db:drop', 'db:create', 'db:migrate', :environment] do
      require 'factory_girl'
      load 'spec/factories.rb'
      require File.expand_path("db/initializer.rb", File.dirname(__FILE__))
      Db::Initializer.prime!
    end
  end
end
