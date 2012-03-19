Feature: Get personal data

  Background:
    Given I am logged in as 0108001416 with pass x5Zu3Yk_1

  Scenario Outline: Getting isee informations about current user
    Given I send and accept <format> 
    When I send a GET request for "/students/0108001416/isee" with the user's key
    Then the response code should be 200 
    And the response should have the following informations about the isee:
      | name    | surname   | student_code | date_of_birth | place_of_birth        | tax_code         | value_scale_equivalence | ise     | isee     | caf_protocol_number  |
      | antonio | antonelli | 0108001416   | 1985-11-12    | cava de' tirreni (sa) | ntnntn85s12c361a | 2.85                    | 38076.2 | 13360.07 | cafcna10-sa004-a0376 |

    # testing with various format 
    Examples:
      | format |
      | JSON   |
      | XML    |
