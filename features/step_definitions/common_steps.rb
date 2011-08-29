Then /^I should have (\d+) ([^"]*)s$/ do |number, model|
  klass = model.camelize.constantize
  if klass.column_names.include?('user_id')
    assert_equal number.to_i, klass.count(:conditions=>{:user_id => @current_user.id})

  elsif klass.column_names.include?('owner_id')
    assert_equal number.to_i, klass.count(:conditions=>{:owner_id => @current_user.id})

  else
    raise "Model #{model.camelize} don't have columns user_id or owner_id. Please specify something else"
  end  
end