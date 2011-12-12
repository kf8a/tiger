Feature: authenticating to the NIS

  Scenario Outline: Authenticating to the NIS by reading a data package
    Given an eml document with read access given to "public" in the root element is inserted by "ucarroll"
    When I read the document as "<user>" with "<password>"
    Then it <output>
    Examples: 
      |user       | password       | output  |
      |ucarroll   | wrong_password | fails with unauthorized |
      |ucarroll   |                | fails with unauthorized |
      |nosuchuser | password       | fails with unauthorized |
