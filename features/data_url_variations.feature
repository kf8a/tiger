Feature: uploading a dataset with various urls

  Scenario: Inserting a document with an informational url
    Given a valid eml document with an informational data url
    When I insert the document into the NIS
    Then it fails with a bad request
    And the document is not in the NIS

  Scenario: Inserting a document with a download url and wrong data
    Given a valid eml document with a download data url
    When I insert the document into the NIS
    Then it fails with a bad request
    And the document is not in the NIS

 Scenario: Inserting a document with inline data
    Given a valid eml document with inline data
    When I insert the document into the NIS
    Then it succeeds

