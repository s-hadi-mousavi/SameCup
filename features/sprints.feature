# Scenario: After creating project it should have sprint and 3 states
#   Given the following project records
#     | name         | alias        | owner_id |
#     | Test Project | test-project | 1       |
# 
#   Given the following project_user records
#     | user_id | role | project_id |
#     | 1       | 1    | 1          |
# 
#   When I go to the projects page
#   And I should see "Test Project"
