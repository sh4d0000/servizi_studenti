Feature: Get study plan

  Background:
    Given I am logged in as 0108001416 with pass x5Zu3Yk_1

  Scenario Outline: Getting the study plan about current user
    Given I send and accept <format> 
    When I send a GET request for "/students/0108001416/study_plan" with the user's key
    Then the response code should be 200 
    And the response should have the following informations:
      | program_year    | teaching                                  | outcome       | cfu | taf  | ssd       |
      | 1               | economia aziendale                        | convalidato   | 6   | c    | secs-p/07 |
      | 1               | program. ii / lab. program. ii cfu 9      | convalidato   | 9   | a    | inf/01    |
      | 1               | programmaz. / lab. programmaz. i cfu 12   | convalidato   | 12  | b    | inf/01    |
      | 3               | prova finale cfu 6                        |               | 6   |      |           |

    # testing with various format 
    Examples:
      | format |
      | JSON   |
      | XML    |

