Feature: Get exam bookings

  Background:
    Given I am logged in as 0108001416 with pass x5Zu3Yk_1

  Scenario Outline: Getting the exam bookings
    Given I send and accept <format> 
    When I send a GET request for "/sessions/bookings" with the user's key
    Then the response code should be 200 
    And the bookings should be the followings:
      | teaching                                                    | date       | time  | classroom      | professor             | booking_number | notes         |
      | cartogr. num. e gis/ lab. cartogr. num. e gis cfu 10 ( 21li ) | 2012-03-27 | 14:30 | ufficio 420    | prof. giulio giunta   | 1              | prova scritta | 

    # testing with various format 
    Examples:
      | format |
      | XML    |
      | JSON   | 
