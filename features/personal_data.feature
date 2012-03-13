Feature: Get personal data

  Background:
    Given I am logged in as 0108001416 with pass x5Zu3Yk_1

  Scenario: Getting personal data about current user in JSON
    Given I send and accept JSON
    When I send a GET request for "/students/0108001416" with the user's key
    Then the response code should be 200 
    And I should have the following informations in JSON format:
      | name    | surname   | gender     | date_of_birth | place_of_birth        | citizenship  | tax_code         |
      | antonio | antonelli | maschile   | 1985-11-12    | cava de' tirreni (sa) |  italiana    | ntnntn85s12c361a |
