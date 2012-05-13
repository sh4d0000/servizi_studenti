Feature: Get passed exams 

  Background:
    Given I am logged in as 0108001416 with pass qwerty12 

  Scenario Outline: Getting the passed exams about current user
    Given I send and accept <format> 
    When I send a GET request for "/students/0108001416/passed_exams" with the user's key
    Then the response code should be 200 
    And the exams should be the followings:
      | code            | name                                      | outcome       | date           |
      | progr9          | program. ii / lab. program. ii cfu 9      | convalidato   |                |
      | progr12         | programmaz. / lab. di programmaz. i cfu12 | convalidato   |                |
      | tw6             | tecnologie web cfu 6                      | 30            | 2011-01-28     |

    # testing with various format 
    Examples:
      | format |
      | JSON   |
      | XML    |

