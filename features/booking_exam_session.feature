Feature: Booking to exam session

  Background:
    Given I am logged in as 0108001416 with pass x5Zu3Yk_1

  Scenario Outline: Booking to an exam session
    Given I send and accept <format>
    Given I have a prenotation url from an exam session
    When I send a POST request to "/sessions/booking" with the user's key and prenotation url
    Then the response code should be 200 
    And the response should have a prenotation number

    # testing with various format 
    Examples:
      | format |
      | JSON   |
      | XML    |

