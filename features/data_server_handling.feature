Feature: handling various errors when accessing the data server

  Scenario: The webserver returns a redirect
    Given a valid eml document with a redirected url
    When I insert the document into the NIS
    Then it succeeds

  Scenario: The webserver returns a bad gateway
    Given a valid eml document where the data server returns a "502" error
    When I insert the document into the NIS
    Then it fails with a bad request 
