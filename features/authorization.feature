Feature: Reading a document in the NIS

  Scenario Outline: Reading a document with a user trying to authenticate 
    Given an eml document with read access given to "<user>" in the root element is inserted by "<submitter>" 
    And I am logged in as "<reader>"
    When I read the document
    Then it <output>
    Examples: Successful access through public
      |submitter|user    |reader     | output   |
      |ucarroll |public  |ucarroll   |succeeds  |
      |ucarroll |public  |cjack      |succeeds  |
      |ucarroll |public  |nosuchuser |succeeds  |
    Examples: successful explicit access
      |submitter|user    |reader     | output   |
      |ucarroll |cjack   |cjack      |succeeds  |
      |cjack    |ucarroll|ucarroll   |succeeds   |
    Examples: can not deny read right to submitter
      |submitter|user   |reader  | output   |
      |ucarroll|cjack  |ucarroll |succeeds  |
    Examples: denied 
      |submitter|user   |reader    | output                  |
      |ucarroll|ucarroll|cjack     | fails with unauthorized |
      |cjack   |cjack   |ucarroll  | fails with unauthorized |
      |ucarroll|ucarroll|nosuchuser| fails with unauthorized |
      |ucarroll|cjack   |nosuchuser| fails with unauthorized |
