package ai.phasechange.gherkin.ast

import ai.phasechange.gherkin.GherkinParser

abstract class AbstractAstVisitor : AstVisitor {
    override fun visit(doc: GherkinDocument) {
        doc.feature?.also { visit(it) }
    }

    override fun visit(docString: GherkinDocString) {
    }

    override fun visit(examplesDefinition: GherkinExamplesDefinition) {
        visit(examplesDefinition.examplesLine)
        visit(examplesDefinition.descriptionHelper)
        examplesDefinition.tags?.also { visit(it) }
        examplesDefinition.dataTable?.also { visit(it) }
    }

    override fun visit(examplesLine: GherkinExamplesLine) {
        examplesLine.other?.also { visit(it) }
    }

    override fun visit(feature: GherkinFeature) {
        visit(feature.featureHeader)
        feature.background?.also { visit(it) }
        feature.rules?.forEach { visit(it) }
        feature.scenarioDefinitions?.forEach { visit(it) }
    }

    override fun visit(featureDescHelper: GherkinFeatureDescHelper) {
        featureDescHelper.featureDescs?.forEach { visit(it) }
    }

    override fun visit(featureHeader: GherkinFeatureHeader) {
        featureHeader.tags?.also { visit(it) }
        visit(featureHeader.featureLine)
        visit(featureHeader.featureDescHelper)
    }

    override fun visit(featureLine: GherkinFeatureLine) {
        featureLine.other?.also { visit(it) }
    }

    override fun visit(featureDesc: GherkinFeatureDesc) {
        visit(featureDesc.featureDesc)
    }

    override fun visit(other: GherkinOther) {
    }

    override fun visit(rule: GherkinRule) {
        visit(rule.ruleHeader)
        rule.background?.also { visit(it) }
        rule.scenarioDefinitions?.forEach { visit(it) }
    }

    override fun visit(ruleHeader: GherkinRuleHeader) {
        ruleHeader.tags?.also { visit(it) }
        visit(ruleHeader.ruleLine)
        visit(ruleHeader.descriptionHelper)
    }

    override fun visit(ruleLine: GherkinRuleLine) {
        ruleLine.other?.also { visit(it) }
    }

    override fun visit(scenario: GherkinScenario) {
        visit(scenario.scenarioLine)
        visit(scenario.descriptionHelper)
        scenario.examplesDefinitions?.forEach { visit(it) }
        scenario.steps?.forEach { visit(it) }
    }

    override fun visit(scenarioDefinition: GherkinScenarioDefinition) {
        scenarioDefinition.tags?.also { visit(it) }
        visit(scenarioDefinition.scenario)
    }

    override fun visit(scenarioLine: GherkinScenarioLine) {
        scenarioLine.other?.also { visit(it) }
    }

    override fun visit(step: GherkinStep) {
        visit(step.stepLine)
        step.stepArg?.also { visit(it) }
    }

    override fun visit(stepLine: GherkinStepLine) {
        stepLine.other?.also { visit(it) }
    }

    override fun visit(stepArg: GherkinStepArg) {
        stepArg.docString?.also { visit(it) }
        stepArg.dataTable?.also { visit(it) }
    }

    override fun visit(tag: GherkinTag) {
    }

    override fun visit(tagline: GherkinTagline) {
        tagline.tagline.forEach { visit(it) }
    }

    override fun visit(tags: GherkinTags) {
        tags.taglines.forEach { visit(it) }
    }

    override fun visit(background: GherkinBackground) {
        visit(background.backgroundLine)
        visit(background.descriptionHelper)
        background.steps?.forEach { visit(it) }
    }

    override fun visit(backgroundLine: GherkinBackgroundLine) {
        backgroundLine.other?.also { visit(it) }
    }

    override fun visit(description: GherkinDescription) {
        description.other.also { visit(it) }
    }

    override fun visit(dataTable: GherkinDataTable) {
    }

    override fun visit(descriptionHelper: GherkinDescriptionHelper) {
        descriptionHelper.descriptions?.forEach { visit(it) }
    }

    override fun visit(anything: GherkinAnything) {
    }
}
