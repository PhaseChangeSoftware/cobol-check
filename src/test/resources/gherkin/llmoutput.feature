Feature: Calculate remaining refund amount for retail transactions

  Scenario: No refunds found and charge amount is zero
    Given charge amount CHG-AMT is 0.00
    And charge count CHG-COUNT is 0
    And charge key CHG-KEY is "TXN001"
    And the RETAILER-REFS file contains no matching records
    When 2400-CHECK-REFUNDS is PERFORMed
    Then the remaining amount REFTRAN-REMAINING-AMT should be 0.00
    And the refunded amount REFTRAN-REFUNDED-AMT should be 0.00

  Scenario: No refunds found and charge amount is positive
    Given charge amount CHG-AMT is 100.00
    And charge count CHG-COUNT is 0
    And charge key CHG-KEY is "TXN002"
    And the RETAILER-REFS file contains no matching records
    When 2400-CHECK-REFUNDS is PERFORMed
    Then the remaining amount REFTRAN-REMAINING-AMT should be 100.00
    And the refunded amount REFTRAN-REFUNDED-AMT should be 0.00

  Scenario: Single refund found with amount less than charge
    Given charge amount CHG-AMT is 100.00
    And charge count CHG-COUNT is 1
    And charge key CHG-KEY is "TXN003"
    And the RETAILER-REFS file contains records:
      | RETREFS-SEQ | RETREFS-ID | RETREFS-AMT |
      | 0           | TXN003     | 30.00       |
    When 2400-CHECK-REFUNDS is PERFORMed
    Then the remaining amount REFTRAN-REMAINING-AMT should be 70.00
    And the refunded amount REFTRAN-REFUNDED-AMT should be 30.00

  Scenario: Multiple refunds found with total less than charge
    Given charge amount CHG-AMT is 150.00
    And charge count CHG-COUNT is 3
    And charge key CHG-KEY is "TXN004"
    And the RETAILER-REFS file contains records:
      | RETREFS-SEQ | RETREFS-ID | RETREFS-AMT |
      | 0           | TXN004     | 25.00       |
      | 1           | TXN004     | 35.00       |
      | 2           | TXN004     | 40.00       |
    When 2400-CHECK-REFUNDS is PERFORMed
    Then the remaining amount REFTRAN-REMAINING-AMT should be 50.00
    And the refunded amount REFTRAN-REFUNDED-AMT should be 100.00

  Scenario: Refunds exceed charge amount
    Given charge amount CHG-AMT is 50.00
    And charge count CHG-COUNT is 2
    And charge key CHG-KEY is "TXN005"
    And the RETAILER-REFS file contains records:
      | RETREFS-SEQ | RETREFS-ID | RETREFS-AMT |
      | 0           | TXN005     | 30.00       |
      | 1           | TXN005     | 40.00       |
    When 2400-CHECK-REFUNDS is PERFORMed
    Then the remaining amount REFTRAN-REMAINING-AMT should be 0.00
    And the refunded amount REFTRAN-REFUNDED-AMT should be 50.00

  Scenario: Remaining amount less than 5.00 threshold
    Given charge amount CHG-AMT is 53.00
    And charge count CHG-COUNT is 1
    And charge key CHG-KEY is "TXN006"
    And the RETAILER-REFS file contains records:
      | RETREFS-SEQ | RETREFS-ID | RETREFS-AMT |
      | 0           | TXN006     | 50.00       |
    When 2400-CHECK-REFUNDS is PERFORMed
    Then the remaining amount REFTRAN-REMAINING-AMT should be 0.00
    And the refunded amount REFTRAN-REFUNDED-AMT should be 53.00

  Scenario: Remaining amount exactly 5.00
    Given charge amount CHG-AMT is 55.00
    And charge count CHG-COUNT is 1
    And charge key CHG-KEY is "TXN007"
    And the RETAILER-REFS file contains records:
      | RETREFS-SEQ | RETREFS-ID | RETREFS-AMT |
      | 0           | TXN007     | 50.00       |
    When 2400-CHECK-REFUNDS is PERFORMed
    Then the remaining amount REFTRAN-REMAINING-AMT should be 5.00
    And the refunded amount REFTRAN-REFUNDED-AMT should be 50.00

  Scenario: Some refund records not found
    Given charge amount CHG-AMT is 200.00
    And charge count CHG-COUNT is 4
    And charge key CHG-KEY is "TXN008"
    And the RETAILER-REFS file contains records:
      | RETREFS-SEQ | RETREFS-ID | RETREFS-AMT |
      | 0           | TXN008     | 40.00       |
      | 2           | TXN008     | 60.00       |
    When 2400-CHECK-REFUNDS is PERFORMed
    Then the remaining amount REFTRAN-REMAINING-AMT should be 100.00
    And the refunded amount REFTRAN-REFUNDED-AMT should be 100.00
