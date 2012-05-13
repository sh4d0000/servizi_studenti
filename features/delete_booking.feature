Feature: Delete booking

  Background:
    Given I am logged in as 0108001416 with pass qwerty12

  Scenario Outline: Deleting a booking to an exam session
    Given I send and accept <format>
    And I have a delete prenotation url from an exam booking
    When I send a DELETE request to "/sessions/bookings" with the user's key and delete prenotation url
    Then the response code should be 200 

    # testing with various format 
    Examples:
      | format |
      | JSON   |
      | XML    |

