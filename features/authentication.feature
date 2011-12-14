Feature: authenticating to the NIS

  Background:
    Given an eml document with read access given to "ucarroll" in the root element is inserted by "ucarroll"

  Scenario: Successful authentication to the NIS
    When I sign in as ucarroll with her password
    Then it succeeds
    
  Scenario Outline: Failed authentication to the NIS by reading a data package
    When I sign in as "<user>" with password "<password>"
    Then it <output>
    Examples: 
      |user       | password       | output                  |
      |ucarroll   | wrong_password | fails with unauthorized |
      |ucarroll   |                | fails with unauthorized |
      |nosuchuser | password       | fails with unauthorized |

  Scenario: Using the authorization token to log in by reading a data package
    When I sign in as ucarroll with her password
    And I read the document with the authentication cookie
    Then it succeeds
 
  Scenario: Reject modified auth-token
    When I sign in as ucarroll with her password
    And I read the document with a modified authentication cookie
    Then it fails with unauthorized

  @slow
  Scenario: Reject time out token
    When I sign in as ucarroll with her password
    And I wait for the auth-token to expire
    And I read the document with the authentication cookie
    Then it fails with unauthorized
   
