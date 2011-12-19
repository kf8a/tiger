Feature: Reading a document in the NIS

  Scenario Outline: Reading a document with a user trying to authenticate 
    Given an eml document with read access given to "<user>" in the root element is inserted by "<submitter>" 
    When I read the document as "<reader>"
    Then it <output>
    Examples: Successful access through public
      |submitter|user    |reader     | output   |
      |ucarroll |public  |ucarroll   |succeeds  |
      |ucarroll |public  |cjack      |succeeds  |
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
      |ucarroll|public  |nosuchuser| fails with unauthorized |

  Scenario Outline: reading a document without trying to authenticate
    Given an eml document with read access given to "<user>" in the root element is inserted by "<submitter>" 
    When I read the document
    Then it <output>
    Examples: 
      |submitter| user  | output                  |
      |ucarroll | public| succeeds                |
      |ucarroll | cjack | fails with unauthorized |

  Scenario Outline: Writing to a document
    Given an eml document with write access given to "<user>" in the root element is inserted by "<submitter>"
    When I update the document as "<writer>"
    Then it <output>
    Examples:
      |submitter | user    | writer | output                  |
      |ucarroll  | ucarroll|ucarroll| succeeds                |
      |ucarroll  | cjack   |cjack   | succeeds                |
      |ucarroll  | cjack   |ucarroll| succeeds                |
      |ucarroll  | ucarroll|cjack   | fails with unauthorized |

  Scenario Outline: Writing to the access element in document
    Given an eml document with write access given to "<user>" in the root element is inserted by "<submitter>"
    When I update the access element of the document as "<writer>"
    Then it <output>
    Examples:
      |submitter | user    | writer | output                  |
      |ucarroll  | ucarroll|ucarroll| succeeds                |
      |ucarroll  | cjack   |ucarroll| succeeds                |
      |ucarroll  | cjack   |cjack   | fails with unauthorized |
      |ucarroll  | ucarroll|cjack   | fails with unauthorized |
