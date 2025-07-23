Feature: Calculate REFTRAN-REMAINING-AMT for rejected transactions

  Scenario: Calculate remaining amount when transaction has no errors and no refunds
    Given a rejected transaction record with transaction ID RTRAN-TRANS-ID of 12345678901234567890
    And the charges master file contains a record with:
      | CHG-KEY             | CHG-ERR-IND | CHG-COUNT | CHG-AMT | CHG-STATE |
      | 12345678901234567890| " "         | 0         | 10000   | FL        |
    And no surcharge paid record exists for transaction ID 12345678901234567890
    And no retailer refund records exist for transaction ID 12345678901234567890
    And no latest refund record exists for transaction ID 12345678901234567890
    When 200-READ-INPUT is performed
    Then the remaining amount REFTRAN-REMAINING-AMT should be 10000

  Scenario: Calculate remaining amount when transaction has partial refunds
    Given a rejected transaction record with transaction ID RTRAN-TRANS-ID of 12345678901234567890
    And the charges master file contains a record with:
      | CHG-KEY             | CHG-ERR-IND | CHG-COUNT | CHG-AMT | CHG-STATE |
      | 12345678901234567890| " "         | 2         | 10000   | FL        |
    And no surcharge paid record exists for transaction ID 12345678901234567890
    And the retailer refunds file contains records:
      | RETREFS-ID          | RETREFS-SEQ | RETREFS-AMT |
      | 12345678901234567890| 0           | 2500        |
      | 12345678901234567890| 1           | 1500        |
    And no latest refund record exists for transaction ID 12345678901234567890
    When 200-READ-INPUT is performed
    Then the remaining amount REFTRAN-REMAINING-AMT should be 6000

  Scenario: Set remaining amount to zero when remaining is less than 5.00
    Given a rejected transaction record with transaction ID RTRAN-TRANS-ID of 12345678901234567890
    And the charges master file contains a record with:
      | CHG-KEY             | CHG-ERR-IND | CHG-COUNT | CHG-AMT | CHG-STATE |
      | 12345678901234567890| " "         | 1         | 1000    | FL        |
    And no surcharge paid record exists for transaction ID 12345678901234567890
    And the retailer refunds file contains records:
      | RETREFS-ID          | RETREFS-SEQ | RETREFS-AMT |
      | 12345678901234567890| 0           | 996         |
    And no latest refund record exists for transaction ID 12345678901234567890
    When 200-READ-INPUT is performed
    Then the remaining amount REFTRAN-REMAINING-AMT should be 0

  Scenario: Set remaining amount to zero when charge amount is zero
    Given a rejected transaction record with transaction ID RTRAN-TRANS-ID of 12345678901234567890
    And the charges master file contains a record with:
      | CHG-KEY             | CHG-ERR-IND | CHG-COUNT | CHG-AMT | CHG-STATE |
      | 12345678901234567890| " "         | 0         | 0       | FL        |
    And no surcharge paid record exists for transaction ID 12345678901234567890
    And no retailer refund records exist for transaction ID 12345678901234567890
    And no latest refund record exists for transaction ID 12345678901234567890
    When 200-READ-INPUT is performed
    Then the remaining amount REFTRAN-REMAINING-AMT should be 0

  Scenario: Set remaining amount to zero when refunds exceed charge amount
    Given a rejected transaction record with transaction ID RTRAN-TRANS-ID of 12345678901234567890
    And the charges master file contains a record with:
      | CHG-KEY             | CHG-ERR-IND | CHG-COUNT | CHG-AMT | CHG-STATE |
      | 12345678901234567890| " "         | 2         | 5000    | FL        |
    And no surcharge paid record exists for transaction ID 12345678901234567890
    And the retailer refunds file contains records:
      | RETREFS-ID          | RETREFS-SEQ | RETREFS-AMT |
      | 12345678901234567890| 0           | 3000        |
      | 12345678901234567890| 1           | 3000        |
    And no latest refund record exists for transaction ID 12345678901234567890
    When 200-READ-INPUT is performed
    Then the remaining amount REFTRAN-REMAINING-AMT should be 0

  Scenario: Calculate remaining amount for CA state with surcharge paid
    Given a rejected transaction record with transaction ID RTRAN-TRANS-ID of 12345678901234567890
    And the charges master file contains a record with:
      | CHG-KEY             | CHG-ERR-IND | CHG-COUNT | CHG-AMT | CHG-STATE |
      | 12345678901234567890| " "         | 0         | 10000   | CA        |
    And a surcharge paid record exists for transaction ID 12345678901234567890
    And no retailer refund records exist for transaction ID 12345678901234567890
    And no latest refund record exists for transaction ID 12345678901234567890
    When 200-READ-INPUT is performed
    Then the remaining amount REFTRAN-REMAINING-AMT should be 10000

  Scenario: Calculate remaining amount for NY state with surcharge paid
    Given a rejected transaction record with transaction ID RTRAN-TRANS-ID of 12345678901234567890
    And the charges master file contains a record with:
      | CHG-KEY             | CHG-ERR-IND | CHG-COUNT | CHG-AMT | CHG-STATE |
      | 12345678901234567890| " "         | 0         | 15000   | NY        |
    And a surcharge paid record exists for transaction ID 12345678901234567890
    And no retailer refund records exist for transaction ID 12345678901234567890
    And no latest refund record exists for transaction ID 12345678901234567890
    When 200-READ-INPUT is performed
    Then the remaining amount REFTRAN-REMAINING-AMT should be 15000