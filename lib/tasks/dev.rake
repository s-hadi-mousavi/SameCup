namespace :samecup do
  namespace :dev do
    desc "Ensure non production"
    task :ensure_non_production_environment do
      raise "You can not run this in production" if Rails.env.production?
    end

    desc "Creates sample data for testing locally"
    task :prime => [:ensure_non_production_environment, 'db:drop', 'db:create', 'db:migrate', :environment] do

      require 'factory_girl'
      FactoryGirl.find_definitions

      module FactoryGirl
        class Proxy
          class Create < Build
            def result_with_progress(*args)
              $stdout.print('.')
              $stdout.flush
              result_without_progress(*args)
            end
            alias_method_chain :result, :progress
          end
        end
      end

      puts
      print "Creating development data..."

      require File.expand_path("db/initializer.rb", File.dirname(__FILE__))
      Db::Initializer.prime!

      print "done.\n"
      puts
      puts "You can now load the root of the application"
      puts
      puts " start command : bundle exec foreman start"
      puts "           url : http://localhost:3002/"
      puts
      puts "the following tasks exists to help with development"
      puts
      puts `rake -T samecup:dev`
      puts

    end
  end
end
