Feature: Get exam sessions

  Background:
    Given I am logged in as 0108001416 with pass x5Zu3Yk_1

  Scenario Outline: Getting the exam sessions
    Given I send and accept <format> 
    When I send a GET request for "/sessions" with the user's key
    Then the response code should be 200 
    And the sessions should be the followings:
      | ssd    | teaching                               | cfu | course             | address        | date       | time  | prenotation_range      | classroom      | professor             | notes                                                     |
      | mat/08 | calcolo numerico cfu 6 ( calcn6 )      | 6   | informatica (0108) | generale (gen) | 2012-03-28 | 12:00 | 2012-03-05 / 2012-03-24 | ufficio 420    | prof. giulio giunta   | seduta riservata esclusivamente agli studenti fuori corso | 

    # testing with various format 
    Examples:
      | format |
      | JSON   |
      | XML    |

