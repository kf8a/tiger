Feature: Inserting a dataset into the Data Package Manager.
  Scenario: Inserting a new data package
    Given a valid eml data package
    When I insert the data package
    Then it succeeds

  Scenario: Inserting a data package twice
    Given a valid eml data package
    When I insert the data package
    Then it succeeds
    When I insert the data package
    Then it fails

  Scenario: Inserting a previously deleted dataset
    Given a valid eml data package in the NIS
    When I delete the data package
    Then it succeeds
    When I insert the data package
    Then it succeeds

