Feature: Get study plan

  Background:
    Given I am logged in as 0108001416 with pass qwerty12

  Scenario Outline: Getting the study plan about current user
    Given I send and accept <format> 
    When I send a GET request for "/students/0108001416/study_plan" with the user's key
    Then the response code should be 200 
    And the study plan should have the following teachings:
      | program_year    | name                                      | outcome       | cfu | taf  | ssd       |
      | 1               | program. ii / lab. program. ii cfu 9      | convalidato   | 9   | a    | inf/01    |
      | 1               | programmaz. / lab. di programmaz. i cfu12 | convalidato   | 12  | b    | inf/01    |
      | 3               | prova finale cfu 6                        |               | 6   |      |           |

    # testing with various format 
    Examples:
      | format |
      | JSON   |
      | XML    |

