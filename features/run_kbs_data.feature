Feature: test all of the KBS's dataset

  Scenario: Given a harvest list
    When check all of the datasets
    Then I see only passing grades.
