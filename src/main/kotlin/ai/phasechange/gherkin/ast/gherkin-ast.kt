package ai.phasechange.gherkin.ast

/**
 * ```
 * gherkinDocument : feature? EMPTY*? EOF ;
 * ```
 */
class GherkinDocument(val feature: GherkinFeature?) : AbstractGherkin()

/**
 * ```
 * feature : noline* featureHeader (EMPTY background)? (EMPTY scenarioDefinition)* (EMPTY rule)* ;
 * ```
 */
class GherkinFeature(
    val featureHeader: GherkinFeatureHeader,
    val background: GherkinBackground?,
    val scenarioDefinitions: List<GherkinScenarioDefinition>?,
    val rules: List<GherkinRule>?
) : AbstractGherkin()

/**
 * ```
 * featureHeader : tags? featureLine featureDescHelper ;
 * ```
 */
class GherkinFeatureHeader(
    val tags: GherkinTags?,
    val featureLine: GherkinFeatureLine,
    val featureDescHelper: GherkinFeatureDescHelper
) : AbstractGherkin()

/**
 * ```
 * rule : noline* ruleHeader background? scenarioDefinition* ;
 * ```
 */
class GherkinRule(
    val ruleHeader: GherkinRuleHeader,
    val background: GherkinBackground?,
    val scenarioDefinitions: List<GherkinScenarioDefinition>?
) : AbstractGherkin()

/**
 * ```
 * ruleHeader : tags? ruleLine descriptionHelper ;
 * ```
 */
class GherkinRuleHeader(
    val tags: GherkinTags?,
    val ruleLine: GherkinRuleLine,
    val descriptionHelper: GherkinDescriptionHelper
) : AbstractGherkin()

/**
 * ```
 * background : noline* backGroundLine descriptionHelper step* ;
 * ```
 */
class GherkinBackground(
    val backgroundLine: GherkinBackgroundLine,
    val descriptionHelper: GherkinDescriptionHelper,
    val steps: List<GherkinStep>?
) : AbstractGherkin()

/**
 * ```
 * scenarioDefinition : noline* tags? scenario ;
 * ```
 */
class GherkinScenarioDefinition(
    val tags: GherkinTags?,
    val scenario: GherkinScenario
) : AbstractGherkin()

/**
 * ```
 * scenario : scenarioLine descriptionHelper (step (EMPTY step)*)* examplesDefinition* ;
 * ```
 */
class GherkinScenario(
    val scenarioLine: GherkinScenarioLine,
    val descriptionHelper: GherkinDescriptionHelper,
    val steps: List<GherkinStep>?,
    val examplesDefinitions: List<GherkinExamplesDefinition>?
) : AbstractGherkin()

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
) : AbstractGherkin()

/**
 * ```
 * step : noline* stepLine (EMPTY stepArg)? ;
 * ```
 */
class GherkinStep(
    val stepLine: GherkinStepLine,
    val stepArg: GherkinStepArg?
) : AbstractGherkin()

/**
 * ```
 * stepArg : (dataTable | docString) ;
 * ```
 */
class GherkinStepArg(
    val dataTable: GherkinDataTable?,
    val docString: GherkinDocString?
) : AbstractGherkin()

/**
 * ...
 * TABLEROW : ('|'((~[|\r\n])|('\\\\|'))*)+(~[\\]'|')(~[\r\n])*;
 */
class GherkinTABLEROW(
    override val name: String,
    override val variables: List<String>?
) : AbstractGherkin(), GherkinVariableString

/**
 * ```
 * dataTable : noline* TABLEROW (noline+ TABLEROW)* ;
 * ```
 */
class GherkinDataTable(
    val tableRows: List<GherkinTABLEROW>
) : AbstractGherkin()

/**
 * ```
 * docString : DOCSTRING1 | DOCSTRING2 | DOCSTRING3 ;
 * ```
 */
class GherkinDocString(
    override val name: String,
    override val variables: List<String>?
) : AbstractGherkin(), GherkinVariableString

/**
 * ```
 * tags : noline* tagline (noline+ tagline)* noline+ ;
 * ```
 */
class GherkinTags(
    val taglines: List<GherkinTagline>
) : AbstractGherkin()

/**
 * ```
 * scenarioLine :  (SCENARIO | OUTLINE)? COLON other? ;
 * ```
 */
class GherkinScenarioLine(
    val outline: Boolean,
    val other: GherkinOther?
) : AbstractGherkin()

/**
 * ```
 * examplesLine :  EXAMPLES COLON other? ;
 * ```
 */
class GherkinExamplesLine(
    val other: GherkinOther?
) : AbstractGherkin()

/**
 * ```
 * featureLine : FEATURE COLON other? ;
 * ```
 */
class GherkinFeatureLine(
    val other: GherkinOther?
) : AbstractGherkin()

/**
 * ```
 * backGroundLine : BACKGROUND COLON other? ;
 * ```
 */
class GherkinBackgroundLine(
    val other: GherkinOther?
) : AbstractGherkin()

/**
 * ```
 * stepLine : (GIVEN | WHEN | THEN | AND | BUT | STAR) other? ;
 * ```
 */
class GherkinStepLine(
    val type: Type,
    val other: GherkinOther?
) : AbstractGherkin() {
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
    val other: GherkinOther?
) : AbstractGherkin()

// needs to handle all forms of whitespace prior to the description
/**
 * ```
 * descriptionHelper : noline? (description noline+)* ;
 * ```
 */
class GherkinDescriptionHelper(
    val descriptions: List<GherkinDescription>?
) : AbstractGherkin()

/**
 * ```
 * description : other ;
 * ```
 */
class GherkinDescription(
    val other: GherkinOther
) : AbstractGherkin()

/**
 * ```
 * featureDescHelper : noline? (featureDesc noline+)* ;
 * ```
 */
class GherkinFeatureDescHelper(
    val featureDescs: List<GherkinFeatureDesc>?
) : AbstractGherkin()

/**
 * ```
 * featureDesc : anything ;
 * ```
 */
class GherkinFeatureDesc(
    val featureDesc: GherkinAnything
) : AbstractGherkin()

/**
 * ```
 * keyword : BACKGROUND | EXAMPLES | FEATURE | OUTLINE | RULE | SCENARIO ;
 * ```
 */
class GherkinKeyword(
    val type: Type
) : AbstractGherkin() {
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
    override val name: String,
    override val variables: List<String>?
) : AbstractGherkin(), GherkinVariableString

/**
 * ```
 * anything: (ANY | AND | BUT | GIVEN | LANGUAGE | STAR | TAG | THEN | WHEN)
 *  (ATSIGN | ANY | AND | BUT | GIVEN | LANGUAGE | STAR | TAG | THEN | WHEN | COLON | keyword)*;
 * ```
 */
class GherkinAnything(
    val description: String
) : AbstractGherkin()

/**
 * ```
 * tagline : TAG+;
 * ```
 */
class GherkinTagline(
    val tagline: List<GherkinTag>
) : AbstractGherkin()

/**
 * ```
 * TAG : TOKEN ;
 * ```
 */
class GherkinTag(
    val tag: String
) : AbstractGherkin()
