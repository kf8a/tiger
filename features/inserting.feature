Feature: Happliy inserting various eml docs into the NIS

  Scenario: Inserting a basic document
    Given a valid eml document
    When I insert the document into the NIS
    Then it succeeds

  Scenario Outline: Inserting with different date time values
    Given a data file and valid eml document with a timestamp of "<timestamp>" and a format of "<format>"
    When I insert the document into the NIS
    Then it succeeds
    Examples: Datetime stamps
      | timestamp               | format                  |
      | 2011-01-01 01:01:03     | YYYY-MM-DD hh:mm:ss     |
      | 2011-01-01T01:01:03     | YYYY-MM-DDThh:mm:ss     |
      | 2011-01-10 15:00:02.034 | YYYY-MM-DD hh:mm:ss.sss |
      | 2011-12-30 23:03:30Z    | YYYY-MM-DD hh:mm:ssZ    |
      | 20110101 102304         | YYYYMMDD hhmmss         |
    Examples: Partial times
      | timestamp               | format                  |
      | 2011-02-02 10           | YYYY-MM-DD hh           |
      | 2011-03-30 10:32        | YYYY-MM-DD hh:mm        |
      | 2011-12-30Z22:03        | YYYY-MM-DDZhh:mm        |
      | 2011-12-12Z09:23:22     | YYYY-MM-DDZhh:mm:ss     |
    Examples: Dates
      | timestamp               | format                  |
      | 2011-01-01              | YYYY-MM-DD              |
      | 01-01-2011              | MM-DD-YYYY              |
      | May 5 2011              | WWW D YYYY              |
      | 2011DEC12               | YYYYWWWDD               |
      | 04/01/2011              | DD/MM/YYYY              |
      | 12/30/2011              | MM/DD/YYYY              |
      | 12/30/11                | MM/DD/YY                |
      | 12-May-2011             | DD-WWW-YYYY             |
    Examples: partial dates
      | timestamp               | format                  |
      | 2011                    | YYYY                    |
      | 2011-05                 | YYYY-MM                 |
      | MAY-2005                | WWW-YYYY                |
      | MAY 2005                | WWW YYYY                |
