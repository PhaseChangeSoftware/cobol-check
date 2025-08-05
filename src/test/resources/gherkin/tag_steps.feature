Feature: tagging steps

@pc_files
Scenario: Check that a file exists
    @filename{CHGFILE}
    Given CHG-KEY is 0
    @useless_tag
    And CHG-REF-STORE exists
