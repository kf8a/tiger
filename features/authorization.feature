Feature: Reading a document in the NIS

  Scenario Outline: Reading a document
    Given an eml document with read access given to "<user>" in the root element is inserted by "<submitter>" 
    And I am logged in as "<reader>"
    When I read the document
    Then the result should be "<output>"
    Examples:
      |submitter|user   |reader  | output  |
      |ucarrol  |public |ucarrol |success  |
      |ucarrol  |public |bohms   |success  |
      |ucarrol  |public |public  |success  |
      |ucarrol  |ucarrol|ucarrol |success  |
      |ucarrol  |bohms  |ucarrol |success  |
      |ucarrol  |ucarrol|bohms   |forbidden|
      |ucarrol  |bohms  |public  |forbidden|
      |ucarrol  |ucarrol|public  |forbidden|
