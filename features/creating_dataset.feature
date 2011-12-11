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
    Then it fails due to a conflict

  Scenario: Inserting a previously deleted dataset
    Given a valid eml data package in the NIS
    When I delete the data package
    Then it succeeds
    When I insert the data package
    Then it fails due to a conflict

  Scenario Outline: Inserting a document with odd package scopes
    Given a valid eml data package with a scope of "<Scope_id>"
    When I insert the data package
    Then it <Outcome>
    Examples:
      | Scope_id     | Outcome                   |
      |knb-lter-ooo  | succeeds                  |
      |knb-lter-other| fails with a server error |
      |knb-othe-ooo  | fails with a server error |
      |lte-kbs-oth   | fails with a server error |
      |knb-othe      | fails with a server error |

