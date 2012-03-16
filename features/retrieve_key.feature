Feature: retrieve key

  Scenario Outline: retrieving access key
    Given I send and accept <format> 
    When I send a GET request for "students/0108001416/key" with password paramameter "x5Zu3Yk_1" 
    Then the response code should be 200
    And the key should be valid

    Examples:
      | format |
      | JSON   |
      | XML    |
