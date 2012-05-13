Feature: Get payments 

  Background:
    Given I am logged in as 0108001416 with pass qwerty12 

  Scenario Outline: Getting the payments made by the current user
    Given I send and accept <format> 
    When I send a GET request for "/students/0108001416/payments/made" with the user's key
    Then the response code should be 200 
    And the payments should be the followings:
      | code | academic_year | description                | amount | date       | status |
      | 3001 | 2011/2012     | versamento tassa regionale | 62.00  | 2011-11-03 | made   |
      | 1001 | 2011/2012     | versamento prima rata      | 287.00 | 2011-11-03 | made   |
      | 3001 | 2010/2011     | versamento tassa regionale | 32.00  | 2010-11-05 | made   |

    # testing with various format 
    Examples:
      | format |
      | JSON   |
      | XML    |

  Scenario Outline: Getting the payments in debt by the current user
    Given I send and accept <format> 
    When I send a GET request for "/students/0108001416/payments/in_debt" with the user's key
    Then the response code should be 200 
    And the payments list should be empty

    # testing with various format 
    Examples:
      | format |
      | JSON   |
      | XML    |
