# Then last|first project should have state(s)
Then /^(\w+) should have (\w+)?$/ do |model, has_many|
  model.camelize.constantize.try(:last).try(has_many).should_not be_empty
end