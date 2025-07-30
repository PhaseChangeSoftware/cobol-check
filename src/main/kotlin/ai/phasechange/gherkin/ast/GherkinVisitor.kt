package ai.phasechange.gherkin.ast

import ai.phasechange.gherkin.GherkinParser
import ai.phasechange.gherkin.GherkinParserBaseVisitor
import org.antlr.v4.runtime.misc.Interval

class GherkinVisitor : GherkinParserBaseVisitor<AbstractGherkin>() {
    override fun visitStartRule(ctx: GherkinParser.StartRuleContext): AbstractGherkin? {
        return visitGherkinDocument(ctx.gherkinDocument())
    }

    override fun visitGherkinDocument(ctx: GherkinParser.GherkinDocumentContext): GherkinDocument? {
        return ctx.feature()?.let {
            GherkinDocument(visitFeature(it))
        }
    }

    override fun visitFeature(ctx: GherkinParser.FeatureContext): GherkinFeature {
        return GherkinFeature(
            visitFeatureHeader(ctx.featureHeader()),
            ctx.background()?.let { visitBackground(it) },
            ctx.scenarioDefinition()?.map {
                visitScenarioDefinition(it)
            },
            ctx.rule_()?.map {
                visitRule(it)
            }
        )
    }

    override fun visitFeatureHeader(ctx: GherkinParser.FeatureHeaderContext): GherkinFeatureHeader {
        return GherkinFeatureHeader(
            ctx.tags()?.let { visitTags(it) },
            visitFeatureLine(ctx.featureLine()),
            visitFeatureDescHelper(ctx.featureDescHelper())
        )
    }

    override fun visitTags(ctx: GherkinParser.TagsContext): GherkinTags {
        return GherkinTags(
            ctx.tagline().map {
                visitTagline(it)
            }
        )
    }

    override fun visitTagline(ctx: GherkinParser.TaglineContext): GherkinTagline {
        return GherkinTagline(
            ctx.TAG().map {
                GherkinTag(it.text)
            }
        )
    }

    override fun visitFeatureLine(ctx: GherkinParser.FeatureLineContext): GherkinFeatureLine {
        return GherkinFeatureLine(
            ctx.other()?.let { visitOther(it) }
        )
    }

    override fun visitOther(ctx: GherkinParser.OtherContext): GherkinOther {
        return GherkinOther(
            ctx.start.inputStream.getText(Interval(ctx.start.startIndex, ctx.stop.stopIndex)),
            ctx.variable()?.map {
                it.ANY().text
            }
        )
    }

    override fun visitFeatureDescHelper(ctx: GherkinParser.FeatureDescHelperContext): GherkinFeatureDescHelper {
        return GherkinFeatureDescHelper(
            ctx.featureDesc().map {
                visitFeatureDesc(it)
            }
        )
    }

    override fun visitFeatureDesc(ctx: GherkinParser.FeatureDescContext): GherkinFeatureDesc {
        return GherkinFeatureDesc(
            visitAnything(ctx.anything())
        )
    }

    override fun visitAnything(ctx: GherkinParser.AnythingContext): GherkinAnything {
        return GherkinAnything(ctx.start.inputStream.getText(Interval(ctx.start.startIndex, ctx.stop.stopIndex)))
    }

    override fun visitBackground(ctx: GherkinParser.BackgroundContext): GherkinBackground {
        return GherkinBackground(
            visitBackGroundLine(ctx.backGroundLine()),
            visitDescriptionHelper(ctx.descriptionHelper()),
            ctx.step()?.map {
                visitStep(it)
            }
        )
    }

    override fun visitStep(ctx: GherkinParser.StepContext): GherkinStep {
        return GherkinStep(
            visitStepLine(ctx.stepLine()),
            ctx.stepArg()?.let { visitStepArg(it) }
        )
    }

    override fun visitStepLine(ctx: GherkinParser.StepLineContext): GherkinStepLine {
        return GherkinStepLine(
            when {
                ctx.WHEN() != null -> GherkinStepLine.Type.WHEN
                ctx.AND() != null -> GherkinStepLine.Type.AND
                ctx.BUT() != null -> GherkinStepLine.Type.BUT
                ctx.GIVEN() != null -> GherkinStepLine.Type.GIVEN
                ctx.THEN() != null -> GherkinStepLine.Type.THEN
                ctx.STAR() != null -> GherkinStepLine.Type.STAR
                else -> GherkinStepLine.Type.STAR
            },
            ctx.other()?.let { visitOther(it) }
        )
    }

    override fun visitStepArg(ctx: GherkinParser.StepArgContext): GherkinStepArg {
        return GherkinStepArg(
            ctx.dataTable()?.let {
                visitDataTable(it)
            },
            ctx.docString()?.let {
                visitDocString(it)
            }
        )
    }

    private fun findVariables(inString: String): List<String>? {
        val regex = Regex("<([^<>]+)>")
        return regex.findAll(inString)
            .map { it.groupValues[1] }
            .toList().ifEmpty { null }
    }

    override fun visitDataTable(ctx: GherkinParser.DataTableContext): GherkinDataTable {
        return GherkinDataTable(
            ctx.TABLEROW().map {
                GherkinTABLEROW(it.text, findVariables(it.text))
            }
        )
    }

    override fun visitDocString(ctx: GherkinParser.DocStringContext): GherkinDocString {
        return GherkinDocString(
            ctx.start.inputStream.getText(Interval(ctx.start.startIndex, ctx.stop.stopIndex)),
            findVariables(ctx.text)
        )
    }

    override fun visitScenario(ctx: GherkinParser.ScenarioContext): GherkinScenario {
        return GherkinScenario(
            visitScenarioLine(ctx.scenarioLine()),
            visitDescriptionHelper(ctx.descriptionHelper()),
            ctx.step()?.map {
                visitStep(it)
            },
            ctx.examplesDefinition()?.map {
                visitExamplesDefinition(it)
            }?.ifEmpty { null }
        )
    }

    override fun visitScenarioLine(ctx: GherkinParser.ScenarioLineContext): GherkinScenarioLine {
        return GherkinScenarioLine(
            ctx.OUTLINE() != null,
            ctx.other()?.let { visitOther(it) }
        )
    }

    override fun visitExamplesDefinition(ctx: GherkinParser.ExamplesDefinitionContext): GherkinExamplesDefinition {
        return GherkinExamplesDefinition(
            ctx.tags()?.let { visitTags(it) },
            visitExamplesLine(ctx.examplesLine()),
            visitDescriptionHelper(ctx.descriptionHelper()),
            ctx.dataTable()?.let { visitDataTable(it) }
        )
    }

    override fun visitExamplesLine(ctx: GherkinParser.ExamplesLineContext): GherkinExamplesLine {
        return GherkinExamplesLine(
            ctx.other()?.let { visitOther(it) }
        )
    }

    override fun visitDescriptionHelper(ctx: GherkinParser.DescriptionHelperContext): GherkinDescriptionHelper {
        return GherkinDescriptionHelper(
            ctx.description()?.map {
                visitDescription(it)
            }
        )
    }

    override fun visitDescription(ctx: GherkinParser.DescriptionContext): GherkinDescription {
        return GherkinDescription(
            visitOther(ctx.other())
        )
    }

    override fun visitBackGroundLine(ctx: GherkinParser.BackGroundLineContext): GherkinBackgroundLine {
        return GherkinBackgroundLine(
            ctx.other()?.let { visitOther(it) }
        )
    }

    override fun visitScenarioDefinition(ctx: GherkinParser.ScenarioDefinitionContext): GherkinScenarioDefinition {
        return GherkinScenarioDefinition(
            ctx.tags()?.let { visitTags(it) },
            visitScenario(ctx.scenario())
        )
    }

    override fun visitRule(ctx: GherkinParser.RuleContext): GherkinRule {
        return GherkinRule(
            visitRuleHeader(ctx.ruleHeader()),
            ctx.background()?.let { visitBackground(it) },
            ctx.scenarioDefinition()?.map { visitScenarioDefinition(it) }
        )
    }

    override fun visitRuleHeader(ctx: GherkinParser.RuleHeaderContext): GherkinRuleHeader {
        return GherkinRuleHeader(
            ctx.tags()?.let { visitTags(it) },
            visitRuleLine(ctx.ruleLine()),
            visitDescriptionHelper(ctx.descriptionHelper()),
        )
    }

    override fun visitRuleLine(ctx: GherkinParser.RuleLineContext): GherkinRuleLine {
        return GherkinRuleLine(
            ctx.other()?.let { visitOther(it) }
        )
    }
}