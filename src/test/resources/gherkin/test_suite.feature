# Comprehensive Gherkin Parser Test Suite
# This file covers all Gherkin language features and edge cases for ANTLR parser testing
@feature_tag1 @feature_tag2
Feature: Comprehensive Gherkin Parser Test Suite
  This is a comprehensive feature description
  that spans multiple lines
  with various formatting

  # Comment in feature description
  and includes comments mixed in

  to test all aspects of Gherkin syntax

  Background: Setup steps
    Given the system is initialized
    And the database is populated

  Scenario: Simple scenario
    Given a basic step
    When an action occurs
    Then something happens

  Scenario: Background testing
    Given a specific condition
    When something happens
    Then verify the result

  @scenario_tag1 @scenario_tag2
  Scenario: Tagged scenario
    Given a tagged step
    When tags are processed
    Then verify tag handling

  Scenario: Step keyword variations
    Given initial condition
    And another condition
    But not this condition
    When an action occurs
    And another action
    Then verify result
    And verify additional result
    But not this result
    * Generic step keyword
    * Another generic step

  Scenario: Data table formats
    Given a standard data table:
      | name  | age | city     |
      | Alice | 25  | New York |
      | Bob   | 30  | London   |

    And a single column table:
      | items |
      | apple |
      | banana|

    And a table with whitespace variations:
      |   name   |age|    city    |
      |  Alice   |25 | New York   |
      |Bob       |30 |London      |

    And a table with empty cells:
      | name  | middle | last    |
      | John  |        | Doe     |
      | Jane  | Marie  |         |

    And a table with special characters:
      | symbol | meaning     |
      | $      | dollar      |
      | @      | at symbol   |
      | #      | hash        |

  Scenario: DocString variations
    Given a basic DocString:
      """
      This is a simple DocString
      with multiple lines
      and various indentation
      """

    And a DocString with content type:
      """json
      {
        "name": "test",
        "value": 123
      }
      """

    And a DocString with alternative delimiters:
      ```
      Alternative delimiter format
      supports same functionality
      ```

    And a DocString with escaped content:
      """
      This contains \"\"\" escaped quotes
      and other special characters
      """

    And a DocString with mixed delimiters:
      ```
      This contains """ inside
      alternative delimiter format
      ```

  Scenario: Comments and whitespace
    # Step-level comment
    Given a step with comment

    # Multiple comments
    # on consecutive lines
    When multiple comments exist

    Then verify comment handling
    # Trailing comment

  Scenario: Whitespace preservation
    Given whitespace matters in data:
      """
      Line with    multiple   spaces
        Indented line

      Line after empty line
      """

  @outline_tag
  Scenario Outline: Parameterized scenario
    Given I have <initial> items
    When I add <more> items
    Then I should have <total> items

    Examples:
      | initial | more | total |
      | 5       | 3    | 8     |
      | 10      | 7    | 17    |

    @example_tag1
    Examples: Tagged example set
      | initial | more | total |
      | 1       | 1    | 2     |

  Scenario: Empty scenario
    # This scenario has no steps (edge case)

  Scenario: Special characters in text
    Given a string with "quotes" and 'apostrophes'
    And symbols like @#$%^&*()
    And unicode characters: café, résumé, naïve
    When processing special characters
    Then handle them correctly

  Scenario Outline: Special characters in parameters
    Given a <symbol> character
    And a <word> with special chars

    Examples:
      | symbol | word     |
      | $      | pa$$word |
      | @      | email@   |
      | #      | hash#tag |

  Scenario Outline: Outline without examples
    Given a step without examples
    # No Examples section

  Scenario Outline: Outline with empty examples
    Given a step with empty examples

    Examples:
      # Empty examples

  Scenario Outline: Outline with header only
    Given a step with header only

    Examples:
      | parameter |
      # No data rows

  Scenario: Complex scenario description
  This scenario has a description
  that spans multiple lines

  with empty lines in between

  # And comments mixed in

    Given the complex setup is complete
    When complex actions occur
    Then verify complex results

  Scenario: Very long lines
    Given a very long step that contains many words and characters to test parser handling of lengthy input strings that might cause buffer or memory issues in some parsing implementations
    And a step with "very long quoted string containing many words and characters that should be properly handled by the parser without causing any issues or errors during the parsing process"

  Scenario: Maximum nesting
    Given deeply nested structure with:
      """
      Level 1 content
        Level 2 content
          Level 3 content
            Level 4 content
              Level 5 content
      """

  Scenario: Unicode support
    Given text with accented characters: café, résumé, naïve
    And text with symbols: €, £, ¥, ©, ®, ™
    When processing international text
    Then handle encoding correctly

  @error_recovery
  Scenario: Malformed but parseable
    Given step with missing colon
    When "quoted text without proper spacing"
    Then verify error recovery

  Scenario: Missing keywords
    # Test parser recovery from missing Given/When/Then
    step without keyword
    When normal step follows
    Then parser should recover

  Scenario Outline: Large parameter sets
    Given parameter <p1> and <p2> and <p3>

    Examples:
      | p1   | p2   | p3   |
      | val1 | val2 | val3 |
      | val4 | val5 | val6 |
      | val7 | val8 | val9 |
      | val10| val11| val12|
      | val13| val14| val15|

  Scenario: All content types together
    Given a step with DocString:
      """json
      {"mixed": "content"}
      """
    And a step with data table:
      | type      | value |
      | DocString | above |
      | Table     | here  |
    When processing mixed content
    Then handle all types correctly

  @multiple @tags @on @single @line
  Scenario: Multiple tag formats
    Given various tag formats

  @joined_tag1@joined_tag2
  Scenario: Joined tags
    Given tags without spaces

  @tag_with_special_chars#hash
  @tag-with-dashes
  @tag_with_underscores
  @123numeric_tag
  Scenario: Tag edge cases
    Given various tag formats with special characters

  Rule: Authentication Rules
    Authentication must be validated

    Background: Auth setup
      Given the auth system is ready

    Scenario: Valid login
      Given valid credentials
      When user logs in
      Then access is granted

    Scenario: Invalid login
      Given invalid credentials
      When user attempts login
      Then access is denied

  Rule: Another rule set

    Scenario: Rule without background
      Given a different context
      Then verify rule isolation

  Rule: Complex rule with description
    This rule has a comprehensive description
    explaining the business logic

    Background: Rule background
      Given rule-specific setup

    @rule_scenario
    Scenario Outline: Complex outline in rule
    Description for the outline
    within a rule context
      Given <param1> and <param2>

      Examples: First example set
      Description for examples
        | param1 | param2 |
        | val1   | val2   |

  @comprehensive @final_test
  Scenario Outline: Everything together
  Testing all features in combination
    Given <param> with data:
      | field | value   |
      | test  | <param> |
    And DocString content:
      """
      Parameter: <param>
      Content with special chars: @#$%
      """
    When processing all together
    Then verify comprehensive handling

    @comprehensive_examples
    Examples:
      | param     |
      | value1    |
      | value@#$  |