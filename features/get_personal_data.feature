Feature: Get personal data
  Scenario Outline: Getting personal data about current user
    Given I am logged in as 0108001416 with pass x5Zu3Yk_1
    And I send and accept <format> 
    When I send a GET request for "/students/0108001416" with the user's key
    Then the response code should be 200 
    And the response should have the following informations about the student:
      | name    | surname   | gender     | date_of_birth | place_of_birth        | citizenship  | tax_code         |
      | antonio | antonelli | maschile   | 1985-11-12    | cava de' tirreni (sa) |  italiana    | ntnntn85s12c361a |

    # testing with various format 
    Examples:
      | format |
      | JSON   |
      | XML    |

  Scenario Outline: Getting personal data with invalid credential
    Given I have an invalid access key
    When I send a GET request for "/students/0108001416" with the user's key
    Then the response code should be 401 

    # testing with various format 
    Examples:
      | format |
      | JSON   |
      | XML    |
