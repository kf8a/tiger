Feature: authenticating to the NIS

  Background:
    Given an eml document with read access given to "ucarroll" in the root element is inserted by "ucarroll"

  Scenario Outline: Authenticating to the NIS by reading a data package
    When I sign in as "<user>" with password "<password>"
    Then it <output>
    Examples: 
      |user       | password       | output                  |
      |ucarroll   | S@ltL@ke       | succeeds                |
      |ucarroll   | wrong_password | fails with unauthorized |
      |ucarroll   |                | fails with unauthorized |
      |nosuchuser | password       | fails with unauthorized |

  Scenario Outline: Using the authorization token to log in by reading a data package
    When I sign in as "<user>" with password "<password>"
    And I read the document with the authentication cookie
    Then it <output>
    Examples:
      |user       | password       | output                  |
      |ucarroll   | S@ltL@ke       | succeeds                |
      |ucarroll   | wrong_password | fails with unauthorized |
      |ucarroll   |                | fails with unauthorized |
      |nosuchuser | password       | fails with unauthorized |
 
  Scenario: Reject modified auth-token
    When I sign in as "ucarroll" with password "S@ltL@ke"
    And I modify the authorization code
    And I read the document with the authentication cookie
    Then it fails with unauthorized

  Scenario: Reject time out token
    When I sign in as "ucarroll" with password "S@ltL@ke"
    And I wait for the auth-token to expire
    And I read the document with the authentication cookie
    Then it fails with unauthorized
   
