Feature: Get exam bookings

  Background:
    Given I am logged in as 0108001416 with pass qwerty12 

  Scenario Outline: Getting the exam bookings
    Given I send and accept <format> 
    When I send a GET request for "/sessions/bookings" with the user's key
    Then the response code should be 200 
    And the bookings should be the followings:
      | teaching                                                    | date       | classroom      | professor             | booking_number | notes         |
      | matematica ii cfu 9 ( matii9 )      | 04/07/2012 09:00 | da definire    | dott. benedetta pellacci   | 1 | potrebbero subire variazioni | 

    # testing with various format 
    Examples:
      | format |
      | XML    |
      | JSON   | 
