require 'factory_girl'

Factory.sequence(:project_name) {|n| "Project #{n.to_s(16)}" }
Factory.sequence(:alias)        {|n| "alias #{n.to_s(16)}" }

Factory.define :project do |p|
  p.name { Factory.next(:project_name) }

  p.after_build do |built_p|
    built_p.alias = built_p.name.slugize
  end
end
