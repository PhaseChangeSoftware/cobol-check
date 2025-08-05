Feature: Calculate REFTRAN-REMAINING-AMT for rejected transactions

  Scenario: Calculate remaining amount when transaction has no errors and no refunds
    Given a rejected transaction record with transaction ID RTRAN-TRANS-ID of 12345678901234567890
    And the charges master file contains a record with:
      | CHG-KEY             | CHG-ERR-IND | CHG-COUNT | CHG-AMT | CHG-STATE |
      | 12345678901234567890| " "         | 0         | 10000   | FL        |
    And no surcharge paid record exists for transaction ID 1234567890123456789
    And no retailer refund records exist for transaction ID 12345678901234567890
    And no latest refund record exists for transaction ID 12345678901234567890
    When 200-READ-INPUT is performed
    Then the remaining amount REFTRAN-REMAINING-AMT should be 10000
