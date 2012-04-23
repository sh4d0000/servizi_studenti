Feature: Get exam sessions

  Background:
    Given I am logged in as 0108001416 with pass x5Zu3Yk_1

  Scenario Outline: Getting the exam sessions
    Given I send and accept <format> 
    When I send a GET request for "/sessions" with the user's key
    Then the response code should be 200 
    And the sessions should be the followings:
      | ssd    | teaching                               | cfu | course             | address        | date               | prenotation_range      | classroom      | professor             | notes                                                     |
      | mat/05 | matematica ii cfu 9 ( matii9 )      | 9   | informatica (0108) | generale (gen) | 04/07/2012 09:00 | 26/03/2012 - 01/07/2012 | da definire    | dott. benedetta pellacci   | potrebbero subire variazioni | 

    # testing with various format 
    Examples:
      | format |
      | JSON   |
      | XML    |

