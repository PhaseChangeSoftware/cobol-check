Feature: PCCTRR Refund Processing for REFTRAN-REMAINING-AMT Calculation

  Scenario: Calculate remaining amount when refunds exist and remaining is above threshold
    Given a rejected transaction record with RTRAN-TRANS-ID of 12345678901234567890
    And the charge master record exists with CHG-AMT of 100.00
    And CHG-ERR-IND is not "E"
    And CHG-COUNT is 3
    And the surcharge check passes
    And retailer refunds exist with total RETREFS-AMT of 30.00
    And no latest refund record exists
    When 200-READ-INPUT is performed
    Then REFTRAN-REMAINING-AMT should be 70.00

  Scenario: Set remaining amount to zero when calculated remaining is negative
    Given a rejected transaction record with RTRAN-TRANS-ID of 12345678901234567890
    And the charge master record exists with CHG-AMT of 50.00
    And CHG-ERR-IND is not "E"
    And CHG-COUNT is 2
    And the surcharge check passes
    And retailer refunds exist with total RETREFS-AMT of 60.00
    And no latest refund record exists
    When 200-READ-INPUT is performed
    Then REFTRAN-REMAINING-AMT should be 0.00

  Scenario: Set remaining amount to zero when remaining is below 5.00 threshold
    Given a rejected transaction record with RTRAN-TRANS-ID of 12345678901234567890
    And the charge master record exists with CHG-AMT of 20.00
    And CHG-ERR-IND is not "E"
    And CHG-COUNT is 2
    And the surcharge check passes
    And retailer refunds exist with total RETREFS-AMT of 16.00
    And no latest refund record exists
    When 200-READ-INPUT is performed
    Then REFTRAN-REMAINING-AMT should be 0.00
    And REFTRAN-REFUNDED-AMT should be 20.00

  Scenario: Set remaining amount to zero when original charge amount is zero
    Given a rejected transaction record with RTRAN-TRANS-ID of 12345678901234567890
    And the charge master record exists with CHG-AMT of 0.00
    And CHG-ERR-IND is not "E"
    And CHG-COUNT is 1
    And the surcharge check passes
    And no retailer refunds exist
    And no latest refund record exists
    When 200-READ-INPUT is performed
    Then REFTRAN-REMAINING-AMT should be 0.00
    And REFTRAN-REFUNDED-AMT should be 0.00

  Scenario: Calculate remaining amount when no refunds exist
    Given a rejected transaction record with RTRAN-TRANS-ID of 12345678901234567890
    And the charge master record exists with CHG-AMT of 150.00
    And CHG-ERR-IND is not "E"
    And CHG-COUNT is 0
    And the surcharge check passes
    And no retailer refunds exist
    And no latest refund record exists
    When 200-READ-INPUT is performed
    Then REFTRAN-REMAINING-AMT should be 150.00
    And REFTRAN-REFUNDED-AMT should be 0.00

  Scenario: Calculate remaining amount with multiple retailer refunds
    Given a rejected transaction record with RTRAN-TRANS-ID of 12345678901234567890
    And the charge master record exists with CHG-AMT of 200.00
    And CHG-ERR-IND is not "E"
    And CHG-COUNT is 3
    And the surcharge check passes
    And retailer refunds exist:
      | RETREFS-SEQ | RETREFS-AMT |
      | 0           | 25.00       |
      | 1           | 30.00       |
      | 2           | 15.00       |
    And no latest refund record exists
    When 200-READ-INPUT is performed
    Then REFTRAN-REMAINING-AMT should be 130.00
    And REFTRAN-REFUNDED-AMT should be 70.00
