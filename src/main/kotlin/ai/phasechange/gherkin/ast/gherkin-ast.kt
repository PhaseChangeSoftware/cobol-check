package ai.phasechange.gherkin.ast

/**
 * ```
 * gherkinDocument : feature? EMPTY*? EOF ;
 * ```
 */
class GherkinDocument(val feature: GherkinFeature?)

/**
 * ```
 * feature : noline* featureHeader (EMPTY background)? (EMPTY scenarioDefinition)* (EMPTY rule)* ;
 * ```
 */
class GherkinFeature(
    val featureHeader: GherkinFeatureHeader,
    val background: GherkinBackground?,
    val scenarioDefinitions: List<GherkinScenarioDefinition>?,
    val rules: List<GherkinRule>
)

/**
 * ```
 * featureHeader : tags? featureLine featureDescHelper ;
 * ```
 */
class GherkinFeatureHeader(
    val tags: GherkinTags?,
    val featureLine: GherkinFeatureLine,
    val featureDescHelper: GherkinFeatureDescHelper
)

/**
 * ```
 * rule : noline* ruleHeader background? scenarioDefinition* ;
 * ```
 */
class GherkinRule(
    val ruleHeader: GherkinRuleHeader,
    val background: GherkinBackground?,
    val scenarioDefinitions: List<GherkinScenarioDefinition>?
)

/**
 * ```
 * ruleHeader : tags? ruleLine descriptionHelper ;
 * ```
 */
class GherkinRuleHeader(
    val tags: GherkinTags?,
    val ruleLine: GherkinRuleLine,
    val descriptionHelper: GherkinDescriptionHelper
)

/**
 * ```
 * background : noline* backGroundLine descriptionHelper step* ;
 * ```
 */
class GherkinBackground(
    val backgroundLine: GherkinBackgroundLine,
    val descriptionHelper: GherkinDescriptionHelper,
    val steps: List<GherkinStep>?
)

/**
 * ```
 * scenarioDefinition : noline* tags? scenario ;
 * ```
 */
class GherkinScenarioDefinition(
    val tags: GherkinTags?,
    val scenario: GherkinScenario
)

/**
 * ```
 * scenario : scenarioLine descriptionHelper (step (EMPTY step)*)* examplesDefinition* ;
 * ```
 */
class GherkinScenario(
    val scenarioLine: GherkinScenarioLine,
    val descriptionHelper: GherkinDescriptionHelper,
    val steps: List<GherkinStep>,
    val examplesDefinitions: List<GherkinExamplesDefinition>?
)

/**
 * ```
 * examplesDefinition : noline* tags? examplesLine descriptionHelper dataTable? ;
 * ```
 */
class GherkinExamplesDefinition(
    val tags: GherkinTags?,
    val examplesLine: GherkinExamplesLine,
    val descriptionHelper: GherkinDescriptionHelper,
    val dataTable: GherkinDataTable?
)

/**
 * ```
 * step : noline* stepLine (EMPTY stepArg)? ;
 * ```
 */
class GherkinStep(
    val stepLine: GherkinStepLine,
    val stepArgs: List<GherkinStepArg>?
)

/**
 * ```
 * stepArg : (dataTable | docString) ;
 * ```
 */
class GherkinStepArg(
    val dataTable: GherkinDataTable?,
    val docString: GherkinDocString?
)

/**
 * ```
 * dataTable : noline* TABLEROW (noline+ TABLEROW)* ;
 * ```
 */
class GherkinDataTable(
    val tableRows: List<String>
)

/**
 * ```
 * docString : DOCSTRING1 | DOCSTRING2 | DOCSTRING3 ;
 * ```
 */
class GherkinDocString(val docString: String)

/**
 * ```
 * tags : noline* tagline (noline+ tagline)* noline+ ;
 * ```
 */
class GherkinTags(
    val tagLines: List<GherkinTagline>
)

/**
 * ```
 * scenarioLine :  (SCENARIO | OUTLINE)? COLON other? ;
 * ```
 */
class GherkinScenarioLine(
    val Outline: Boolean,
    val other: GherkinOther
)

/**
 * ```
 * examplesLine :  EXAMPLES COLON other? ;
 * ```
 */
class GherkinExamplesLine(
    val other: GherkinOther
)

/**
 * ```
 * featureLine : FEATURE COLON other? ;
 * ```
 */
class GherkinFeatureLine(
    val other: GherkinOther
)

/**
 * ```
 * backGroundLine : BACKGROUND COLON other? ;
 * ```
 */
class GherkinBackgroundLine(
    val other: GherkinOther
)

/**
 * ```
 * stepLine : (GIVEN | WHEN | THEN | AND | BUT | STAR) other? ;
 * ```
 */
class GherkinStepLine(
    val type: Type,
    val other: GherkinOther
) {
    enum class Type {
        GIVEN,
        WHEN,
        THEN,
        AND,
        BUT,
        STAR
    }
}

/**
 * ```
 * ruleLine : RULE COLON other? ;
 * ```
 */
class GherkinRuleLine(
    val other: GherkinOther
)

// needs to handle all forms of whitespace prior to the description
/**
 * ```
 * descriptionHelper : noline? (description noline+)* ;
 * ```
 */
class GherkinDescriptionHelper(
    val descriptions: List<GherkinDescription>
)

/**
 * ```
 * description : other ;
 * ```
 */
class GherkinDescription(
    val other: GherkinOther
)

/**
 * ```
 * featureDescHelper : noline? (featureDesc noline+)* ;
 * ```
 */
class GherkinFeatureDescHelper(
    val featureDescs: List<GherkinFeatureDesc>?
)

/**
 * ```
 * featureDesc : anything ;
 * ```
 */
class GherkinFeatureDesc(
    val featureDesc: GherkinAnything
)

/**
 * ```
 * keyword : BACKGROUND | EXAMPLES | FEATURE | OUTLINE | RULE | SCENARIO ;
 * ```
 */
class GherkinKeyword(
    val type: Type
) {
    enum class Type {
        BACKGROUND,
        EXAMPLES,
        FEATURE,
        OUTLINE,
        RULE,
        SCENARIO
    }
}

/**
 * ```
 * other : ((ANY | keyword)
 *  (ATSIGN | ANY | AND | BUT | GIVEN | LANGUAGE | STAR | TAG | THEN | WHEN | keyword)
 *    (ATSIGN | ANY | AND | BUT | GIVEN | LANGUAGE | STAR | TAG | THEN | WHEN | COLON | keyword)*) |
 *  (ANY (ATSIGN | ANY | AND | BUT | GIVEN | LANGUAGE | STAR | TAG | THEN | WHEN | COLON | keyword)*) |
 *    keyword;
 * ```
 */
class GherkinOther(
    val words: List<String>
)

/**
 * ```
 * anything: (ANY | AND | BUT | GIVEN | LANGUAGE | STAR | TAG | THEN | WHEN)
 *  (ATSIGN | ANY | AND | BUT | GIVEN | LANGUAGE | STAR | TAG | THEN | WHEN | COLON | keyword)*;
 * ```
 */
class GherkinAnything(
    val words: List<String>
)

/**
 * ```
 * tagline : TAG+;
 * ```
 */
class GherkinTagline(
    val tagline: GherkinTagline
)