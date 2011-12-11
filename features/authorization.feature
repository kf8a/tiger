Feature: Reading a document in the NIS

  Scenario Outline: Reading a document
    Given an eml document with read access given to "<user>" in the root element is inserted by "<submitter>" 
    And I am logged in as "<reader>"
    When I read the document
    Then it <output>
    Examples:
      |submitter|user   |reader  | output  |
      |ucarrol  |public |ucarrol |succeeds  |
      |ucarrol  |public |bohms   |succeeds  |
      |ucarrol  |public |public  |succeeds  |
      |ucarrol  |ucarrol|ucarrol |succeeds  |
      |ucarrol  |bohms  |ucarrol |succeeds  |
      |ucarrol  |ucarrol|bohms   |fails with forbidden|
      |ucarrol  |bohms  |public  |fails with forbidden|
      |ucarrol  |ucarrol|public  |fails with forbidden|
